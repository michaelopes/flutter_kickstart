import 'package:example/pages/splash/splash_viewmodel.dart';
import 'package:flutter_kickstart/flutter_kickstart.dart';

import 'pages/home/home_page.dart';
import 'pages/home/home_viewmodel.dart';
import 'pages/main/main_page.dart';
import 'pages/main/main_second_page.dart';
import 'pages/main/main_second_viewmodel.dart';
import 'pages/main/main_viewmodel.dart';
import 'pages/settings/settings_page.dart';
import 'pages/settings/settings_viewmodel.dart';
import 'pages/splash/splash_view.dart';
import 'pages/widgets/initial_bottom_navigator.dart';

class AppRoutes {
  static const splash = "/";
  static const home = "/home";
  static const main = "/main";
  static const settings = "/settings";
  static const mainSecond = "/second";

  static List<FkBaseModule> get modules {
    return [
      FkModule.singleView(
        path: splash,
        builder: (context, goRouterStat) => SplashView(),
        viewModelFactory: () => SplashViewModel(),
      ),
      FkModuleGroup(
        builder: (_, __, child) {
          return InitialBottomNavigator(child: child);
        },
        modules: [
          FkModule(
            views: [
              FkModuleView(
                path: home,
                builder: (context, goRouterStat) => HomeView(),
                viewModelFactory: HomeViewModel.new,
                transitionType: TransitionType.fadeIn,
              ),
            ],
          ),
          FkModule(
            views: [
              FkModuleView(
                path: main,
                builder: (context, goRouterStat) => MainView(),
                viewModelFactory: () => MainViewModel(),
                transitionType: TransitionType.fadeIn,
              ),
              FkModuleView(
                path: mainSecond,
                builder: (context, goRouterStat) => MainSecondView(),
                viewModelFactory: () => MainSecondViewModel(),
              ),
            ],
          ),
          FkModule(
            views: [
              FkModuleView(
                path: settings,
                builder: (context, goRouterStat) => SettingsView(),
                viewModelFactory: () => SettingsViewModel(),
              ),
            ],
          ),
        ],
      )
    ];
  }
}
