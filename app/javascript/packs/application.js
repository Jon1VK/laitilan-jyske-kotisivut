// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import * as ActiveStorage from '@rails/activestorage';
import { Turbo } from '@hotwired/turbo-rails';
import '@rails/actiontext';
import '../initializers/trix';
import * as Hamburgers from '../initializers/hamburgers';
import * as Dropdowns from '../initializers/dropdowns';
import * as PreformatConverter from '../initializers/preformat_converter';

ActiveStorage.start();

function init() {
  Hamburgers.init();
  Dropdowns.init();
  PreformatConverter.convert();
}

function clean() {
  Hamburgers.close();
  Dropdowns.close();
}

document.addEventListener('turbo:load', () => {
  init();
});

document.addEventListener('turbo:submit-end', () => {
  Turbo.clearCache();
});

document.addEventListener('turbo:before-cache', () => {
  clean();
});
