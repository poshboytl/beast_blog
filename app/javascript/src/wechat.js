import QRCode from "qrcode";

$(document).on('turbolinks:load', () => {
  $('#wechat-share-modal').on('show.bs.modal', function (e) {
    let canvas = document.getElementById('wechat-qrcode-canvas');
    let url = window.location.href;

    QRCode.toCanvas(canvas, url, function (error) {
      if (error) console.error(error);
      console.log('success!');
    });
  });

});
