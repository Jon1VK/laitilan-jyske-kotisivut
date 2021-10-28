import { Controller } from '@hotwired/stimulus';
import { get } from '@rails/request.js';

export default class extends Controller {
  load_page(e) {
    const page = e.target.dataset.page;
    get(`/uutiset`, {
      responseKind: 'turbo-stream',
      query: { page },
    });
  }
}
