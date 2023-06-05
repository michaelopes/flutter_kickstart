import 'package:example/pages/services/test_service.dart';
import 'package:flutter_kickstart/flutter_kickstart.dart';

class Injections {
  static void inject() {
    FkInject.I.add<ITestService>(() => TestService());
  }
}
