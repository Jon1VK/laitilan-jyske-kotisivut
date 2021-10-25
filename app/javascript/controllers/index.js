import { application } from './application';

import TrixController from './trix_controller';
application.register('trix', TrixController);

import RecordController from './record_controller';
application.register('record', RecordController);

import ModalController from './modal_controller';
application.register('modal', ModalController);

import EventController from './event_controller';
application.register('event', EventController);
