import '@hotwired/turbo-rails';
import '../controllers/administrate';
import * as ActiveStorage from '@rails/activestorage';

Turbo.session.drive = false;

ActiveStorage.start();
