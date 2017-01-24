$(document).ready(function(){
  // activate the clicked navbar menu
  $('.navbar a').hover(function(){
    $('.menu a').removeClass('active');
    $(this).addClass('active');
  });
});
