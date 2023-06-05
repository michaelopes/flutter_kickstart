import 'package:example/modules.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kickstart/flutter_kickstart.dart';

class InitialBottomNavigator extends FkSimpleView {
  InitialBottomNavigator({super.key, required this.child});

  final Widget child;

  int get currentIndex => switch (nav.location) {
        AppRoutes.main => 1,
        AppRoutes.settings => 2,
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
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Main"),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings")
        ],
        onTap: (index) {
          switch (index) {
            case 1:
              nav.go("/main");
              break;
            case 2:
              nav.go("/settings");
              break;
            default:
              nav.go("/home");
              break;
          }
        },
      ),
    );
  }
}
