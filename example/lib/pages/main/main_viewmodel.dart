import 'package:flutter_kickstart/flutter_kickstart.dart';

import '../../app_reactive.dart';
import '../../model.dart';

class MainReactive extends AppReactive {
  MainReactive() {
    list = FkList();
    user = Model(
      name: "Douglas",
      enable: false,
    );
  }
  FkList<int> get list;
  set list(FkList<int> value);

  Model get user;
  set user(Model model);
}

class MainViewModel extends FkViewModel<MainReactive> {
  MainViewModel() : super(reactive: MainReactive());

  void increment() {
    // reactive.counter++;
    reactive.global.counter++;
    reactive.user.enable = !reactive.user.enable;
  }

  void setModuleValue() {
    addModuleValue("ModuleVariable", "This is a global module variable");
  }

  @override
  void init() {
    print("MainViewmodel setup");
  }
}
