import 'package:flutter/material.dart';
import 'package:flutter_kickstart/flutter_kickstart.dart';

import 'main_second_tab_viewmodel.dart';

class MainSecondTabPage extends FkView<MainSecondTabViewModel> {
  MainSecondTabPage({super.key});

  @override
  Widget builder(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MainSecondTabPage"),
      ),
      body: SizedBox.expand(
        child: Container(
          color: Colors.amber,
        ),
      ),
    );
  }
}
