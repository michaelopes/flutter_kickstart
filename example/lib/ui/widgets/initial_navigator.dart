import 'package:example/setup/app_modules.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kickstart/flutter_kickstart.dart';

class InitialNavigator extends FkSimpleView {
  InitialNavigator({super.key, required this.child});

  final Widget child;

  int get currentIndex => switch (nav.location) {
        AppModules.useAssets => 1,
        AppModules.useResponsive => 2,
        AppModules.drink => 3,
        _ => 0
      };

  @override
  Widget builder(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.abc),
            label: "Typografy",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            label: "Use Assets",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.aspect_ratio),
            label: "Use Responsive",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wine_bar),
            label: "Drink",
          )
        ],
        onTap: (index) {
          switch (index) {
            case 1:
              nav.go(AppModules.useAssets);
              break;
            case 2:
              nav.go(AppModules.useResponsive);
              break;
            case 3:
              nav.go(AppModules.drink);
              break;
            default:
              nav.go(AppModules.typography);
              break;
          }
        },
      ),
    );
  }
}
