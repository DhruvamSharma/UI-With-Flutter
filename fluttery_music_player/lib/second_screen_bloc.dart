import 'package:rxdart/rxdart.dart';
class SecondScreenBloc {

  bool visible = false;

  Stream<bool> get visibilityStream => _visibilityStreamController.stream;

  final _visibilityStreamController = BehaviorSubject<bool>();

  void show() {
    _visibilityStreamController.sink.add(true);
  }

  void dispose() {
    _visibilityStreamController.close();
  }

  void init() {
    _visibilityStreamController.sink.add(false);
  }

}

var secondBloc = SecondScreenBloc();