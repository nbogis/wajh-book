jQuery(function() {
  // activate the clicked navbar menu
  $('.navbar a').hover(function(){
    $('.menu a').removeClass('active');
    $(this).addClass('active');
  });

  $('.ui.search')
  .search({
    apiSettings: {
    action: 'search',
    url: '/users/search_users.json?query={query}',
    debug: 1,
    onResponse (response) {
      return {
        results: response.myresults
      }
      response.myresults.forEach((item) => {
        item.title = item.name;
      });
    }
  },
  fields: {
      results: 'items',
      title: 'name',
      url: 'html_url',
      description: 'description'
  },
    searchFullText: false
  })
;
});
