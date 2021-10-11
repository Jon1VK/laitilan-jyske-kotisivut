import { Controller } from '@hotwired/stimulus';
import { convertPreformattedText } from '../preformatted_text/convert_preformatted_text';

export default class extends Controller {
  connect() {
    console.log('HELLOOOO');
    convertPreformattedText();
  }
}
