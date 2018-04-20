import Swal from 'sweetalert2'

$(document).on('turbolinks:load', () => {

  $("#reset-password").click( ()=> {
    let dataNode = $("#reset-password");
    let dataLink = dataNode.data("link");
    let dataTitle = dataNode.data("title");
    let dataButton = dataNode.data("button");
    let dataText = dataNode.data("text");

    Swal.queue([{
      title: dataTitle,
      confirmButtonText: dataButton,
      text: dataText,
      showLoaderOnConfirm: true,
      preConfirm: () => {
        return $.ajax({
          url: dataLink,
          type: 'POST',
          cache: false,
          data: {},
          processData: false,
          contentType: false
        }).done(data =>
          Swal.insertQueueStep(data.info)
        )
      }
    }])

  })
});

