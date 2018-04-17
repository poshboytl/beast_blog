$(document).on('turbolinks:load', () => {
  $(".upload-avatar-button").click(()=> {
    $('#author-avatar').click()
  });

  $("#author-avatar").on('change', (e)=> {
    let filePath = e.target.value;
    let fileName = filePath.replace(/^.*[\\\/]/, '')
    $(".upload-avatar-button").text(fileName);
  });
});

