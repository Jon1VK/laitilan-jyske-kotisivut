import { Controller } from '@hotwired/stimulus';
import { get } from '@rails/request.js';

export default class extends Controller {
  static targets = ['leagueSelect', 'disciplineSelect'];

  connect() {
    this.change();
  }

  change() {
    const discipline = this.disciplineSelectTarget.selectedOptions[0].value;
    const league = this.leagueSelectTarget.selectedOptions[0].value;
    get(`/seuraennatykset/disciplines`, {
      responseKind: 'turbo-stream',
      query: { league, discipline },
    });
  }
}
