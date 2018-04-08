import { getUrlParam, removeUrlParam, insertUrlParam } from "./url_params";

$(document).on('turbolinks:load', () => {
  let tagStr = getUrlParam("tag");
  if (tagStr) {
    let t = $(".tag-container").find(`[data-name='${tagStr}']`)
    t.addClass("tag-text-color");
    t.data("choose", "true")
  }

  $(".tag-button").click((e) => {
    let target = $(e.target);
    let dataId = $(e.target).data("id");
    let dataChoose = $(e.target).data("choose");
    let dataName = target.data("name");

    if (dataChoose) {
      $(e.target).removeClass("tag-text-color");
      removeUrlParam("tag")
    } else {
      $(e.target).addClass("tag-text-color");
      insertUrlParam("tag", dataName);
    }

    $(e.target).data("choose", !dataChoose)
  });

});

