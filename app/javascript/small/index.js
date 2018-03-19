import Turbolinks from 'turbolinks';

// jquery
import jQuery from "jquery";

window.$ = window.jQuery = jQuery;

import {} from 'jquery-ujs';

// Bootstrap
import 'bootstrap/dist/js/bootstrap';
import './stylesheets/application.scss';

// src
import './medium-editor';
import './images/index';

Turbolinks.start();
