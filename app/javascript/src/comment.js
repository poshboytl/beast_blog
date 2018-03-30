$(document).on('turbolinks:load', () => {
  let dataId = undefined;
  $(".reply-to").click((e) => {
    dataId = $(e.target).data("id");
    let dataName = $(e.target).data("name");
    $(".reply-to-user-name").text(dataName);
    $(".reply-to-user").removeAttr('hidden');
    $(".cancel-reply").removeAttr('hidden');

  });

  $(".cancel-reply").click((e) => {
    $(".reply-to-user").attr('hidden', 'true');
    $(".cancel-reply").attr('hidden', 'true');
    dataId = undefined;
  });

  $("#submit-comment").click(()=>{
    if(dataId) {
      $(".parent-id-field").val(dataId);
    }
  })
});

