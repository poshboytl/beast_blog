$(document).on('turbolinks:load', () => {
  // search form
  let $searchIcon= $(".icon-search");
  let $searchInput = $(".search-input");
  $searchIcon.click( (e)=> {
    e.stopPropagation();
    $searchInput.toggleClass("search-input-active")
    if($searchInput.hasClass("search-input-active")) {
      $searchInput.focus()
    }
  });

  $(".search").click((e) => {
    e.stopPropagation();
  });

  $(document).click((e) => {
    if ($searchInput.hasClass('search-input-active')) {
      $searchInput.removeClass('search-input-active');
    }
  });
});

