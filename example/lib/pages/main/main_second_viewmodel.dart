import 'package:flutter_kickstart/flutter_kickstart.dart';

class MainSecondViewModel extends FkViewModel {
  MainSecondViewModel() : super(reactive: EmptyReactive());

  @override
  Future<void> init() async {
    print("MainSecondViewmodel  setup");
  }

  String get moduleVariable {
    print("moduleVariable");
    return getModuleValue("ModuleVariable");
  }
}
