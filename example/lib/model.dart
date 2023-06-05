import 'package:flutter_kickstart/flutter_kickstart.dart';

class Model extends FkReactive {
  final String name;

  set enable(bool value);
  bool get enable;

  Model({
    required this.name,
    bool enable = false,
  }) {
    this.enable = enable;
  }
}
