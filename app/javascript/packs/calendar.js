import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import listPlugin from "@fullcalendar/list"; 
import interactionPlugin from "@fullcalendar/interaction"; 

document.addEventListener('DOMContentLoaded', function() {
  var calendarEl = document.getElementById('calendar');
  if (!calendarEl) return;

  var calendar = new Calendar(calendarEl, {
    plugins: [dayGridPlugin, listPlugin, interactionPlugin],
    initialView: 'dayGridMonth',
    locale: "ja", 
    events: '/public/users/calendar',
    editable: true,

    dateClick: function(info) {
      alert('${info.dateStr}がクリックされました');
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
            date: info.event.startStr
          }
        })
      }).then(response => {
        if (!response.ok) {
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