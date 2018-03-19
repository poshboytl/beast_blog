// medium-editor
import MediumEditor from 'medium-editor';

$(document).on('turbolinks:load', () => {
  let editor = new MediumEditor('.editable');
});

