import 'package:flutter_kickstart/flutter_kickstart.dart';

abstract class ISplashPresenter {}

class SplashViewModel extends FkViewModel {
  SplashViewModel() : super(reactive: EmptyReactive());
  @override
  void init() {}
}
