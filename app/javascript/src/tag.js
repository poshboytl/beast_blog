import { getUrlParam, removeUrlParam, insertUrlParam } from "./url_params";
import URL from 'url-parse';

$(document).on('turbolinks:load', () => {
  let tagArray = getUrlParam("tags[]");
  if (Array.isArray(tagArray)) {
    tagArray.forEach((e)=> {
      let t = $(".tag-container").find(`[data-name='${e}']`)
      t.addClass("tag-text-color");
      t.data("choose", "true")
    })
  }

  $(".tag-button").click((e) => {
    let target = $(e.target);
    let dataId = $(e.target).data("id");
    let dataChoose = $(e.target).data("choose");
    let dataName = target.data("name");

    if (dataChoose) {
      let index = tagArray.indexOf(dataName);
      if (index > -1) {
        tagArray.splice(index, 1);
      }
    } else {
      tagArray = tagArray || []
      tagArray.push(dataName)
    }

    let searchString = "?"
    let locale = getUrlParam("locale");
    if(locale) {
      searchString += `&locale=${locale}`
    }

    tagArray.forEach((tag)=> {
      searchString += `&tags[]=${tag}`
    })

    window.location.search = searchString

    $(e.target).data("choose", !dataChoose)
  });

});

