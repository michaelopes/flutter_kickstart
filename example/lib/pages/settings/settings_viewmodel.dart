import 'package:flutter_kickstart/flutter_kickstart.dart';

class SettingsViewModel extends FkViewModel {
  SettingsViewModel() : super(reactive: EmptyReactive());

  @override
  Future<void> init() async {
    print("SettingsViewmodel setup");
    addModuleValue("ModuleVariable", "This is a global module variable");
  }
}
