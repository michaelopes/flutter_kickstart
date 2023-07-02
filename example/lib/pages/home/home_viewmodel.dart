import 'package:example/services/test_service.dart';

import 'package:flutter_kickstart/flutter_kickstart.dart';

class HomeViewModel extends FkViewModel {
  HomeViewModel() : super(reactive: EmptyReactive());

  ITestService get service => locator.get();

  @override
  void init() {}
}
