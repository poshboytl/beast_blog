// jquery
import jQuery from "jquery";

window.$ = window.jQuery = jQuery;

// medium-editor
import MediumEditor from 'medium-editor';

$(document).on('turbolinks:load', () => {
  let editor = new MediumEditor('.editable');
});

