import 'package:flutter_kickstart/flutter_kickstart.dart';

class GlobalReactive extends FkReactive {
  static final GlobalReactive _singleton = GlobalReactive._internal();

  factory GlobalReactive() {
    return _singleton;
  }

  GlobalReactive._internal();

  @override
  init() {
    counter = 0;
    initialized = false;
    isLogged = false;
  }

  int get counter;
  set counter(int value);

  set initialized(bool value);
  bool get initialized;

  set isLogged(bool value);
  bool get isLogged;
}
