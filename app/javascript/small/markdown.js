$(document).on('turbolinks:load', () => {
  $("#preview").click(() => {
    let content = $("#content").val();

    $.post("/posts/preview", {content: content}, (data) => {
      $("#content-preview").html(data.preview);
    });

  });
});
