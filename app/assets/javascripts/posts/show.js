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

  // select all likes and change the clicked one to unlike
  // select all ids start with likes_
  $("[id^='like_']").on('click', function() {
    $('#' + this.id).find('i').toggleClass('like empty heart');

    IncrementLikes.init();
  });
});

var IncrementLikes = (function (){
  var init = function () {

  };
});
