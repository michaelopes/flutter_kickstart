import 'dart:async';

import 'package:example/global_reactive.dart';
import 'package:example/setup/app_modules.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kickstart/flutter_kickstart.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Here is an example of the views middleware system. In this case,
/// it checks if the user is logged into the app; if yes, it redirects
/// them to the 'Home = Typography' view; if the user is not logged in,
/// they are directed to the login view.
final class AppModuleMiddleware extends FkModuleMiddleware<GlobalReactive> {
  AppModuleMiddleware() : super(reactive: GlobalReactive()) {
    _initialAppChecks();
  }

  Future<void> _initialAppChecks() async {
    var sharedPreferences = await SharedPreferences.getInstance();
    reactive.isLogged = sharedPreferences.getBool("LOGIN_KEY") ?? false;
    await Future.delayed(const Duration(milliseconds: 2000));
    reactive.initialized = true;
  }

  @override
  FutureOr<String?> onViewRedirect(BuildContext context, GoRouterState state) {
    final isGoingToInit = state.location == AppModules.splash;
    final isGoingToLogin = state.location == AppModules.login;

    if (!reactive.initialized && !isGoingToInit) {
      return AppModules.splash;
    } else if (reactive.initialized && !reactive.isLogged && !isGoingToLogin) {
      return AppModules.login;
    } else if ((reactive.isLogged && isGoingToLogin) ||
        (reactive.isLogged && reactive.initialized && isGoingToInit)) {
      return AppModules.typography;
    } else {
      return null;
    }
  }
}
