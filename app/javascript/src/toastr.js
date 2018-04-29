import toastr from 'toastr';

$(document).on('turbolinks:load', () => {

  let notice = $("#notice");
  if (notice.length > 0) {
    let flash = notice.data("flash");
    flash.forEach((f) => {
      showMsg(f[0], f[1]);
    })
  }
});

function showMsg(name, msg) {
  if (name === "success") {
    toastr.success(msg);
  } else if (name === "danger") {
    toastr.error(msg);
  } else {
    toastr.info(msg);
  }
}
