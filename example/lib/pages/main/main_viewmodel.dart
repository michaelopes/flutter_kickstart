import 'package:flutter_kickstart/flutter_kickstart.dart';

import '../../app_reactive.dart';
import '../../model.dart';

class MainReactive extends FkReactive with AppReactive {
  @override
  init() {
    list = FkList();
    user = Model(
      name: "Douglas d",
      enable: false,
    );
    name2 = "Joana 555 dd";
    novo2 = "TSADASD  444444 55";
    novo3 = "DKJDSJKSDJKSDJKSD";
    novo4 = "pppppppppp";
  }

  String get name2;
  set name2(String value);

  String get novo2;
  set novo2(String value);

  String get novo3;
  set novo3(String value);

  String get novo4;
  set novo4(String value);

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
