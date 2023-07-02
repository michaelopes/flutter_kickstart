import 'package:flutter_kickstart/flutter_kickstart.dart';

import '../services/test_service.dart';

class AppInjections {
  void _services() {
    FkInject.I.add<ITestService>(() => TestService());
  }

  void _repositories() {}

  List<void Function()> get() {
    return [
      _repositories,
      _services,
    ];
  }
}
