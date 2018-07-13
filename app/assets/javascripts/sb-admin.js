$(document).on('turbolinks:load', function() {
  'use strict';
  $('.navbar-sidenav [data-toggle='tooltip']').tooltip({
    template: '<div class='tooltip navbar-sidenav-tooltip' role='tooltip' style='pointer-events: none;'><div class='arrow'></div><div class='tooltip-inner'></div></div>'
  }),
  $('#sidenavToggler').click(function(o) {
    o.preventDefault(),
    $('body').toggleClass('sidenav-toggled'),
    $('.navbar-sidenav .nav-link-collapse').addClass('collapsed'),
    $('.navbar-sidenav .sidenav-second-level, .navbar-sidenav .sidenav-third-level').removeClass('show')
  }),
  $('.navbar-sidenav .nav-link-collapse').click(function(o) {
    o.preventDefault(),
    $('body').removeClass('sidenav-toggled')
  }),
  $('body.fixed-nav .navbar-sidenav, body.fixed-nav .sidenav-toggler, body.fixed-nav .navbar-collapse').on('mousewheel DOMMouseScroll', function(e) {
    var o = $.originalEvent
      , t = o.wheelDelta || -o.detail;
    this.scrollTop += 30 * (t < 0 ? 1 : -1),
    $.preventDefault()
  }),
  $(document).scroll(function() {
    $(this).scrollTop() > 100 ? $('.scroll-to-top').fadeIn() : $('.scroll-to-top').fadeOut()
  }),
  $('[data-toggle='tooltip']').tooltip(),
  $(document).on('click', 'a.scroll-to-top', function(o) {
    var t = $(this);
    $('html, body').stop().animate({
      scrollTop: $(t.attr('href')).offset().top
    }, 1e3, 'easeInOutExpo'),
    o.preventDefault()
  })
});

