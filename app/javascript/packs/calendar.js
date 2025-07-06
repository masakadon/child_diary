import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import listPlugin from "@fullcalendar/list"; 
import interactionPlugin from "@fullcalendar/interaction"; 

document.addEventListener('turbolinks:load', function() {
  var calendarEl = document.getElementById('calendar');  
  // idがcalendarというhtmlを指定してcalendarElという変数に代入している
  if (!calendarEl) return;

  var calendar = new Calendar(calendarEl, {
    plugins: [dayGridPlugin, listPlugin, interactionPlugin],
    initialView: 'dayGridMonth',
    locale: "ja", 
    events: '/users/calendar',
    // /users/calendarのパスのルーティングを呼び出す
    // /users/calendar(.:format)のパスの場合、public/users(コントローラー)#calendar(アクション)が呼び出される
    editable: true,

    dateClick: function(info) {
      const form = document.getElementById('event-form');
      const dateField = document.getElementById('event-start-date');

      if (form && dateField) {
        form.style.display = 'block';
        dateField.value = info.dateStr;
        window.scrollTo({ top: form.offsetTop - 100, behavior: 'smooth' });
      }
    },
    
    eventDrop: function(info) {
      const csrfToken = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
      fetch(`/events/${info.event.id}`, {
        method: 'PATCH',
        headers: {
          'Content-Type': 'application/json',
          'X-CSRF-Token': csrfToken
        },
        body: JSON.stringify({
          event: {
            start: info.event.startStr
          }
        })
      }).then(response => {
        if (response.ok) {
          var notice_message = document.getElementById("alert-message");
          notice_message.innerHTML="<div class='alert alert-success alert-dismissible fade show' role='alert'>"+
         "予定を更新しました"+
          "<button type='button' class='close' data-dismiss='alert' aria-label='Close'>"+
          "<span aria-hidden='true'>&times;</span>"+
           "</button></div>"
        } else{
          alert('更新に失敗しました');
        }
      });
    },

    eventClick: function(info) {
      if (info.event.url) {
        window.location.href = info.event.url;
      }
    },


    windowResize: function () { 
      if (window.innerWidth < 991.98) {
          calendar.changeView('listMonth');
      } else {
          calendar.changeView('dayGridMonth');
      }
    },
  });

  calendar.render();
});

// var calendar = new Calendar(calendarEl, { 11行目のvar calendarを読み込んでいる