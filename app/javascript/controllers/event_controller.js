import { Controller } from '@hotwired/stimulus';
import { get } from '@rails/request.js';

export default class extends Controller {
  get(e) {
    get(`/tapahtumat/${e.currentTarget.dataset.eventId}`, {
      responseKind: 'turbo-stream',
    });
  }
}
