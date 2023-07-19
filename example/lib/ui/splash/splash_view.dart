import 'package:example/assets_snippeds/app_animations.dart';

import 'package:flutter/material.dart';
import 'package:flutter_kickstart/flutter_kickstart.dart';

import 'splash_viewmodel.dart';

class SplashView extends FkView<SplashViewModel> {
  SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Ghost animation import
            theme.animations.splash2,
            const SizedBox(
              height: 32,
            ),
            //Import animation  by snipped
            theme
                .assets<AppAnimationsSnippets>()
                .splash
                .toAnimation(onLoaded: (duration) {}),
          ],
        ),
      ),
    );
  }
}
