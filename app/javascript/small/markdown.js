import Ladda from 'ladda';

$(document).on('turbolinks:load', () => {
  $("#preview").click(() => {
    let content = $("#content").val();

    $.post("/posts/preview", {content: content}, (data) => {
      $("#content-preview").html(data.preview);
    });

  });

  $("#image-wrap").click(()=> {
    $('#image').click()
  });

  let ladda = Ladda.create(document.querySelector('#image-wrap'));
  $("#image").on('change', () => {
    let imageFile = $('#image')[0].files[0];
    if(imageFile === undefined) {
      return
    }

    ladda.start();

    let formData = new FormData();
    formData.append('photo[image]', imageFile);
    $.ajax({
      url: '/photos',
      type: 'POST',
      cache: false,
      data: formData,
      processData: false,
      contentType: false
    }).done((res) => {
      ladda.stop();
      let image = res;

      let text = document.getElementById('content');
      insertAtCursor(text, `![](${image.url})`);
    }).fail((res) => {
      ladda.stop();
    });
  });


  function insertAtCursor(myField, myValue) {
    if (document.selection) {
      //IE support
      myField.focus();
      sel = document.selection.createRange();
      sel.text = myValue;
      sel.select();
    } else if (myField.selectionStart || myField.selectionStart == '0') {
      //MOZILLA/NETSCAPE support
      let startPos = myField.selectionStart;
      let endPos = myField.selectionEnd;
      let beforeValue = myField.value.substring(0, startPos);
      let afterValue = myField.value.substring(endPos, myField.value.length);

      myField.value = beforeValue + myValue + afterValue;

      myField.selectionStart = startPos + myValue.length;
      myField.selectionEnd = startPos + myValue.length;
      myField.focus();
    } else {
      myField.value += myValue;
      myField.focus();
    }
  }
});
