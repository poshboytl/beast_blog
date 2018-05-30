import { getUrlParam, removeUrlParam, insertUrlParam } from "./url_params";
import 'slick-carousel';

$(document).on('turbolinks:load', () => {
  Turbolinks.clearCache();

  $(".slick").slick({
    slidesToShow: 5,
    slidesToScroll: 4,
    dots: false,
    infinite: false,
    responsive: [{

      breakpoint: 1024,
      settings: {
        slidesToShow: 3,
      }

    }, {

      breakpoint: 600,
      settings: {
        slidesToShow: 2,
      }

    }, {

      breakpoint: 400,
      settings: {
        slidesToShow: 1,
      }

    }]
  });

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
    let author = getUrlParam("author");
    if(author) {
      searchString += `&author=${author}`;
    }

    tagArray = [...new Set(tagArray)]

    tagArray.forEach((tag)=> {
      searchString += `&tags[]=${tag}`
    })

    window.location.search = searchString

    $(e.target).data("choose", !dataChoose)
  });

});

