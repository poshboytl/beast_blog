import { insertUrlParam } from "./url_params";

$(document).on('turbolinks:load', () => {
  $(".chinese").click(() => {
    setLocale("zh-CN");
  });

  $(".english").click(() => {
    setLocale("en");
  });

  function setLocale(locale) {
    insertUrlParam("locale", locale)
  }
});

