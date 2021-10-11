import { application } from './application';

import RecordController from './record_controller.js';
application.register('record', RecordController);

import TrixController from './trix_controller.js';
application.register('trix', TrixController);
