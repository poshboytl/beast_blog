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
import './comment';
import './images/index';
import './wechat';
import './i18n';
import './tag';
import './author';
import './sweet';

Rails.start();
Turbolinks.start();
