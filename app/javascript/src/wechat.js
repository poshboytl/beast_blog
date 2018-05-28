import QRCode from "qrcode";

$(document).on('turbolinks:load', () => {
  // for fix bug of modal behind of backdrop
  $('.modal').on('show.bs.modal', function (e) { $('.modal').detach().appendTo('body')})

  $('#wechat-share-modal').on('show.bs.modal', function (e) {
    let canvas = document.getElementById('wechat-qrcode-canvas');
    let url = window.location.href;

    QRCode.toCanvas(canvas, url, function (error) {
      if (error) console.error(error);
    });
  });

});
