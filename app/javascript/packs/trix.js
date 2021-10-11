import * as Trix from 'trix';
import '@rails/actiontext';

// Cofingure new buttons
Trix.config.blockAttributes.floatLeft = {
  tagName: 'sub',
  group: false,
  terminal: true,
};

Trix.config.blockAttributes.floatRight = {
  tagName: 'sup',
  group: false,
  terminal: true,
};

// insert the button visual in the default toolbar
document.addEventListener('trix-initialize', function (event) {
  const floatLeftButton =
    '<button class="trix-button trix-button--icon trix-button--icon-float-left" type="button" data-trix-attribute="floatLeft" tabindex="-1"></button>';
  const floatRightButton =
    '<button class="trix-button trix-button--icon trix-button--icon-float-right" type="button" data-trix-attribute="floatRight" tabindex="-1"></button>';

  const fileTools = event.target.toolbarElement.querySelector(
    '.trix-button-group--file-tools'
  );
  fileTools.insertAdjacentHTML('beforeend', floatLeftButton);
  fileTools.insertAdjacentHTML('beforeend', floatRightButton);
});
