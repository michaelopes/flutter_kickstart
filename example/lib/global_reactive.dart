import 'package:flutter_kickstart/flutter_kickstart.dart';

class GlobalReactive extends FkReactive {
  static final GlobalReactive _singleton = GlobalReactive._internal();

  factory GlobalReactive() {
    return _singleton;
  }
  GlobalReactive._internal() {
    counter = 0;
  }

  int get counter;
  set counter(int value);
}
