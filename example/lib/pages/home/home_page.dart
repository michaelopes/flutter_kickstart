import 'package:example/pages/home/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kickstart/flutter_kickstart.dart';

class HomeView extends FkView<HomeViewModel> {
  HomeView({super.key});

  @override
  Widget builder(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("HOME"),
      ),
    );
  }
}
