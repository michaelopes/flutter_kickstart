import 'package:example/pages/home/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kickstart/flutter_kickstart.dart';

class HomeView extends FkView<HomeViewModel> {
  HomeView({super.key});

  @override
  Widget builder(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    color: Colors.blue.shade100,
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    color: Colors.blue.shade200,
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    color: Colors.blue.shade300,
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    color: Colors.blue.shade400,
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    color: Colors.blue.shade500,
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    color: Colors.blue.shade600,
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    color: Colors.blue.shade700,
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    color: Colors.blue.shade800,
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    color: Colors.blue.shade900,
                  ),
                ],
              ), //aki
            ],
          ),
        ),
      ),
    );
  }
}
