// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import * as ActiveStorage from '@rails/activestorage';
import { Turbo } from '@hotwired/turbo-rails';
import '../controllers/index';
import * as Hamburgers from '../initializers/hamburgers';
import * as Dropdowns from '../initializers/dropdowns';

ActiveStorage.start();

document.addEventListener('turbo:load', () => {
  Hamburgers.init();
  Dropdowns.init();
});

document.addEventListener('turbo:submit-end', () => {
  Turbo.clearCache();
});

document.addEventListener('turbo:before-cache', () => {
  Hamburgers.close();
  Dropdowns.close();
});
