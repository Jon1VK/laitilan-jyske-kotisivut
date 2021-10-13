import { application } from './application';

import TrixController from './trix_controller';
application.register('trix', TrixController);

import RecordController from './record_controller';
application.register('record', RecordController);
