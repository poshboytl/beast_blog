import Turbolinks from 'turbolinks';

// jquery
import jQuery from "jquery";

window.$ = window.jQuery = jQuery;

import Rails from 'rails-ujs';

// Bootstrap
import 'bootstrap/dist/js/bootstrap';
import './stylesheets/application.scss';

// src
import './markdown';
import './images/index';

Rails.start();
Turbolinks.start();
