import 'package:example/assets_snippeds/app_animations.dart';
import 'package:example/modules.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kickstart/flutter_kickstart.dart';

import 'splash_viewmodel.dart';

class SplashView extends FkView<SplashViewModel> {
  SplashView({super.key});

  @override
  Widget builder(BuildContext context) {
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
            theme.assets<AppAnimations>().splash.toAnimation(
                onLoaded: (duration) {
              Future.delayed(
                duration,
                () {
                  //  Fk.navigator.replaceAllWithName(Modules.home);
                  nav.go(AppRoutes.home);
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}



/*class SplashPage extends FkStatefulPage<ISplashViewmodel> {
  SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    print("SplashPage aki");
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Ghost animation import
            widget.animations.splash2,
            const SizedBox(
              height: 32,
            ),
            //Import animation  by snipped
            widget.assets<AppAnimations>().splash.toAnimation(
                onLoaded: (duration) {
              Future.delayed(
                duration,
                () {
                  //  Fk.navigator.replaceAllWithName(Modules.home);
                  widget.nav.go(Modules.mainSecond);
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}*/

/*class SplashPage extends FkStatelessPage<ISplashViewmodel> {
  SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    print("SplashPage aki");
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Ghost animation import
            animations.splash,
            const SizedBox(
              height: 32,
            ),
            //Import animation  by snipped
            assets<AppAnimations>().splash.toAnimation(onLoaded: (duration) {
              Future.delayed(
                duration,
                () {
                  //  Fk.navigator.replaceAllWithName(Modules.home);
                  nav.go(Modules.home);
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}*/
