jQuery(function() {
  // activate the clicked navbar menu
  $('.navbar a').hover(function(){
    $('.menu a').removeClass('active');
    $(this).addClass('active');
  });

  $('.ui.search').search({
    apiSettings: {
      url: '/users/search.json?query={query}',
      // onResponse (response) {
      //   return {
      //     results: response.users
      //   };
      //   response.users.forEach((item) => {
      //     item.title = item.username;
      //   });
      // },

      onResponse : function(theresponse) {
        console.log(theresponse);
        var response = {
            results : {}
          };

        $.each(theresponse.users, function(index, user) {
          console.log(user);
          var username = user.username || 'Unknown',  maxResults = 8;

          if(response.results[username] === undefined) {
            response.results[username] = {
                name: username,
                results: []
            };
          }
          // add result to category
          response.results[username].results.push({
            title       : user.username,
            description : user.first_name,
            url         : user.last_name
          });
        return response;
        });
      }
    },
    type: 'standard',
    source : users,
    searchFields   : [
        'username',
        'first_name',
        'last_name'
    ],
    searchFullText: false,
  });
});
