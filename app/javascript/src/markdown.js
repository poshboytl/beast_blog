import Ladda from 'ladda';

$(document).on('turbolinks:load', () => {
  $("#preview-button").click(() => {
    let content = $("#content").val();

    $.post("/posts/preview", {content: content}, (data) => {
      $(".post-preview").html(data.preview);
    });

    // switch status
    $(".preview-status").removeAttr("hidden");
    $(".edit-status").attr("hidden", true);
  });

  $("#edit-button").click(()=> {
    $(".edit-status").removeAttr("hidden");
    $(".preview-status").attr("hidden", true);
  });

  $("#image-wrap").click(()=> {
    $('#image').click()
  });

  $(".upload-cover-button").click(()=> {
    $(".cover-field").click();
  });

  $("#cover-field").on('change', (e)=> {
    let filePath = e.target.value;
    let fileName = filePath.replace(/^.*[\\\/]/, '')
    $("#upload-cover-text").text(fileName);
  });

  let imageWrap = document.querySelector('#image-wrap');
  let ladda = null;
  if(imageWrap) {
     ladda = Ladda.create(imageWrap);
  }

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

  // cache article title and content
  $("#title").blur(()=> {
    let title = $("#title").val();
    localStorage.setItem("title", title);
  });

  $("#content").blur(() => {
    let content = $("#content").val();
    localStorage.setItem("content", content);
  });

  $(".submit-post").click(() => {
    clearPostCache()
  });

  // load tile and content cache when page load
  loadPostCache();

  function loadPostCache() {
    let title = localStorage.getItem("title");
    let content = localStorage.getItem("content");
    if (title) {
      $("#title").val(title);
    }
    if (content) {
      $("#content").val(content);
    }
  }

  function clearPostCache() {
    localStorage.removeItem("title");
    localStorage.removeItem("content");
  }

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
