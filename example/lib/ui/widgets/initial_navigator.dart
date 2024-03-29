import 'package:example/setup/app_modules.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kickstart/flutter_kickstart.dart';

class InitialNavigator extends FkWidget {
  InitialNavigator({super.key, required this.child});

  final Widget child;

  int get currentIndex => switch (router.state.matchedLocation) {
        AppModules.useAssets => 1,
        AppModules.useResponsive => 2,
        AppModules.drink => 3,
        AppModules.validations => 4,
        _ => 0
      };

  @override
  Widget build(BuildContext context) {
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
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist),
            label: "Validations",
          )
        ],
        onTap: (index) {
          switch (index) {
            case 1:
              router.nav.go(AppModules.useAssets);
              break;
            case 2:
              router.nav.go(AppModules.useResponsive);
              break;
            case 3:
              router.nav.go(AppModules.drink);
              break;
            case 4:
              router.nav.go(AppModules.validations);
              break;
            default:
              router.nav.go(AppModules.typography);
              break;
          }
        },
      ),
    );
  }
}
