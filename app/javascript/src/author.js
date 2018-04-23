$(document).on('turbolinks:load', () => {
  $(".upload-avatar-button").click(()=> {
    $('#author-avatar').click()
  });

  $("#author-avatar").on('change', (e)=> {
    let filePath = e.target.value;
    let fileName = filePath.replace(/^.*[\\\/]/, '')
    $(".upload-avatar-button").text(fileName);
  });

  $("#unpublish").click(()=> {
    let path = $("#unpublish").data("path");

    publishOrUnpublish(path, false);
  });

  $("#publish").click(()=> {
    let path = $("#publish").data("path");

    publishOrUnpublish(path, true);
  });

  function publishOrUnpublish(path, published) {
    let data = {
      post: {
        published: published
      }
    };

    $.ajax({
      url: path,
      type: 'PUT',
      cache: false,
      data: data,
    }).done((res) => {
      location.reload();
      return true
    }).fail((res) => {
      return false
    });
  }


});

