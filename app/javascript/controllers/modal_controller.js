import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  connect() {
    document
      .getElementById('modal-background')
      .addEventListener('click', (e) => {
        e.target.parentElement.classList.remove('open');
      });
  }
}
