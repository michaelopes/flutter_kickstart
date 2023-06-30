import 'package:example/assets_snippeds/app_animations.dart';
import 'package:example/assets_snippeds/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kickstart/flutter_kickstart.dart';

import 'assets_snippeds/app_images.dart';
import 'injections.dart';
import 'modules.dart';

void main() async {
  await Fk.init(
    i18nDirectory: "assets/i18n/",
    availableLanguages: ["pt_BR"],
    defaultLocale: const Locale("pt", "BR"),
    httpDriverMiddleware: AppHttpMiddleware(),
    httpDriverResponseParser: AppHttpResponseParser(),
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
      globalFailureHandler: AppGlobalError(),
      theme: FkThemeData.single(
        data: FkTheme.light(
          colorPalete: FkColorPalete(
            primary: FkColor(
              shade500: Colors.amber,
            ),
          ),
          iconsDirectory: "assets/icons/",
          imagesDirectory: "assets/images/",
          animationsDirectory: "assets/animations/",
          themeBranchs: (mainTheme) {
            return [
              FkThemeBranch(
                name: "MainView",
                theme: mainTheme.copyWith(
                  colorPalete: FkColorPalete(
                    primary: FkColor.color(
                      color: Colors.red,
                    ),
                  ),
                ),
              )
            ];
          },
          assetsSnippets: [
            AppAnimations(),
            AppIcons(),
            AppImages(),
          ],
        ),
      ),
    ),
  );
}

class AppGlobalError extends IGlobalFailureHandler {
  @override
  void onFailure(BuildContext context, Object error, StackTrace stackTrace) {}
}

class AppHttpMiddleware extends IFkHttpDriverMiddleware {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    return handler.next(options);
  }
}

final class AppHttpResponseParser extends FkBaseHttpDriverResponseParser {
  @override
  FkHttpDriverResponse range200(FkHttpDriverResponse response) {
    return response;
  }

  @override
  FkHttpDriverResponse range400(FkHttpDriverResponse response) {
    return response;
  }

  @override
  FkHttpDriverResponse range500(FkHttpDriverResponse response) {
    return response;
  }
}
