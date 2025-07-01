import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import listPlugin from "@fullcalendar/list"; 

document.addEventListener('DOMContentLoaded', function() {
  var calendarEl = document.getElementById('calendar');

  var calendar = new Calendar(calendarEl, {
    plugins: [dayGridPlugin, listPlugin],
    initialView: 'dayGridMonth',
    locale: "ja", 
    events: '/public/users/calendar',
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