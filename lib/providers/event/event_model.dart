import 'package:flutter/foundation.dart';
import 'package:injector/injector.dart';
import 'package:pomangam_client_flutter/domains/event/event.dart';
import 'package:pomangam_client_flutter/repositories/event/event_repository.dart';

class EventModel with ChangeNotifier {

  EventRepository _eventRepository;

  Event event;
  List<Event> events = List();

  bool isFetching = false;

  EventModel() {
    _eventRepository = Injector.appInstance.getDependency<EventRepository>();
  }

  Future<void> fetch({
    @required int dIdx
  }) async {
    isFetching = true;
    try {
      this.events = await _eventRepository.findAll(dIdx: dIdx);
    } catch (error) {
      print('[Debug] EventModel.fetch Error - $error');
      isFetching = false;
    }
    isFetching = false;
    notifyListeners();
  }

  Future<void> fetchOne({
    @required int eIdx
  }) async {
    isFetching = true;
    try {
      this.event = await _eventRepository.findByIdx(eIdx: eIdx);
    } catch (error) {
      print('[Debug] EventModel.fetchOne Error - $error');
      isFetching = false;
    }
    isFetching = false;
    notifyListeners();
  }
}