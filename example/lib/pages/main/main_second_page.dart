import 'package:flutter/material.dart';
import 'package:flutter_kickstart/flutter_kickstart.dart';

import '../widgets/reactive_widget.dart';
import 'main_second_viewmodel.dart';

class MainSecondView extends FkView<MainSecondViewModel> {
  MainSecondView({
    super.key,
  });

  @override
  Widget builder(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MainSecondPage"),
      ),
      body: SizedBox.expand(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(vm.moduleVariable),
            const Text("ReactiveWidget"),
            ReactiveWidget()
          ],
        )),
      ),
    );
  }
}
