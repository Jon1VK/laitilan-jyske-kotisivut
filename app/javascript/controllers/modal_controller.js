import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  connect() {
    document
      .getElementById('modal-background')
      .addEventListener('click', () => {
        document.getElementById('modal').classList.remove('open');
      });
    document.getElementById('modal-close').addEventListener('click', () => {
      document.getElementById('modal').classList.remove('open');
    });
  }
}
