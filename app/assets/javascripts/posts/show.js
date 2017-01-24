// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready(function(){
  // tab the pointing menus
  $('.pointing .item').tab();

  // flip profile picture
  $('.sides').on('click', function(){
    $('.shape').shape('flip back');
  });

  // tab the menu in the About segment
  $('.four .item').tab();
});
