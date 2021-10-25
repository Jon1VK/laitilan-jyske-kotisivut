import { Controller } from '@hotwired/stimulus';

window.addEventListener('hashchange', () => {
  const modal = document.getElementById('modal');

  if (location.hash != '#modal') {
    modal.classList.remove('open');
  }
});

export default class extends Controller {
  static targets = ['closeBtn', 'background'];

  connect() {
    location.hash = 'modal';

    this.backgroundTarget.addEventListener('click', () => {
      history.back();
    });

    this.closeBtnTarget.addEventListener('click', () => {
      history.back();
    });
  }
}
