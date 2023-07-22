import 'package:example/setup/app_injections.dart';
import 'package:example/setup/app_module_middleware.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kickstart/flutter_kickstart.dart';

import 'setup/app_global_error_handler.dart';
import 'setup/app_http_middleware.dart';
import 'setup/app_http_response_parse.dart';
import 'setup/app_modules.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Fk.init(
    i18nDirectory: "assets/i18n/",
    availableLanguages: ["pt_BR"],
    defaultLocale: const Locale("pt", "BR"),
    httpDriverMiddleware: AppHttpMiddleware(),
    moduleMiddleware: AppModuleMiddleware(),
    httpDriverResponseParser: AppHttpResponseParser(),
    baseUrl: "https://www.thecocktaildb.com/api/json",
  );

  runApp(
    FkApp(
      appTitle: "Flutter Kickstart",
      //Register app modules
      modules: () => AppModules().modules,
      //Register app injections
      injections: AppInjections().get,
      //Register app global error handler
      globalFailureHandler: AppGlobalError(),
      //Register app theme
      theme: AppTheme().theme,
    ),
  );
}
