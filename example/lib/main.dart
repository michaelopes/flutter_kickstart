import 'package:example/assets_snippeds/app_animations.dart';
import 'package:example/assets_snippeds/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kickstart/flutter_kickstart.dart';

import 'assets_snippeds/app_images.dart';
import 'injections.dart';
import 'modules.dart';

void main() async {
  await Fk.init(
    animationsDirectory: "assets/animations/",
    iconsDirectory: "assets/icons/",
    imagesDirectory: "assets/images/",
    i18nDirectory: "assets/i18n/",
    availableLanguages: ["pt_BR"],
    defaultLocale: const Locale("pt", "BR"),
  );

  runApp(
    FkApp(
      appTitle: "Flutter Kickstart",
      //Register app modules
      modules: () => AppRoutes.modules,
      //Register app injections
      injections: () => [
        Injections.inject,
      ],
      //Register app Icons, Images and Animation snippes.
      assetsSnippeds: [
        AppAnimations(),
        AppIcons(),
        AppImages(),
      ],
      globalFailureHandler: AppGlobalError(),
    ),
  );
}

class AppGlobalError extends IGlobalFailureHandler {
  @override
  void onFailure(BuildContext context, Object error, StackTrace stackTrace) {}
}
