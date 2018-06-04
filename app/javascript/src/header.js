$(document).on('turbolinks:load', () => {
  // search form
  const $searchInput = $('.search-input')

  $('.search').click((e) => {
    e.stopPropagation()
    $searchInput.focus()
  })

})

