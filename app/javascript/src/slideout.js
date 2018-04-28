import Slideout from "slideout"

$(document).on('turbolinks:load', () => {
  let slideout = new Slideout({
    'panel': document.getElementById('panel'),
    'menu': document.getElementById('menu'),
    'side': 'right',
    'padding': 256,
    'tolerance': 70,
    'touch': false
  });

  // Toggle button
  document.querySelector('.toggle-button').addEventListener('click', function() {
    slideout.toggle();
  });
});

