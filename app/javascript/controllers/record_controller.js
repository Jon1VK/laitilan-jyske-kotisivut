import { Controller } from '@hotwired/stimulus';
import { get } from '@rails/request.js';

export default class extends Controller {
  static targets = ['leagueSelect'];

  connect() {
    const league = this.leagueSelectTarget.selectedOptions[0].value;
    get(`/admin/records/disciplines?league=${league}`, {
      responseKind: 'turbo-stream',
    });
  }

  change() {
    const league = this.leagueSelectTarget.selectedOptions[0].value;
    get(`/admin/records/disciplines?league=${league}`, {
      responseKind: 'turbo-stream',
    });
  }
}
