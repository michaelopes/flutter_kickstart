import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_kickstart/src/model/fk_font.dart';

import '../http_driver/fk_http_driver_middleware.dart';
import '../http_driver/fk_http_driver_response_parser.dart';
import '../i18n/i18n.dart';
import '../interfaces/fk_asset.dart';
import 'fk_infos.dart';
import 'fk_load_font.dart';

import 'fk_globals.dart' as globals;

class Fk {
  static Future<dynamic> init({
    String env = "",
    String i18nDirectory = "",
    String iconsDirectory = "",
    String imagesDirectory = "",
    String animationsDirectory = "",
    Locale defaultLocale = const Locale("en"),
    List<FkFont> fonts = const [],
    List<Future> extraInits = const [],
    List<String> availableLanguages = const [],
    List<FkAsset> assetsSnippeds = const [],
    FkBaseHttpDriverResponseParser? httpDriverResponseParser,
    bool enableHttpDriverLogger = true,
    IFkHttpDriverMiddleware? httpDriverMiddleware,
  }) async {
    WidgetsFlutterBinding.ensureInitialized();

    globals.animationsDirectory = animationsDirectory;
    globals.imagesDirectory = imagesDirectory;
    globals.iconsDirectory = iconsDirectory;
    globals.i18nDirectory = i18nDirectory;
    globals.assetsSnippeds = assetsSnippeds;
    globals.enableHttpDriverLogger = enableHttpDriverLogger;

    if (httpDriverResponseParser != null) {
      globals.httpDriverResponseParser = httpDriverResponseParser;
    }

    if (httpDriverMiddleware != null) {
      globals.httpDriverMiddleware = httpDriverMiddleware;
    }

    if (env.isNotEmpty) {
      await dotenv.load(fileName: env);
    }
    return Future.wait<dynamic>([
      ...extraInits,
      FkInfos.I.init(),
      ...fonts.map((e) => FpLoadFont.run(e)),
      if (i18nDirectory.isNotEmpty)
        I18n.I.init(
          filePath: i18nDirectory,
          defaultLocale: defaultLocale,
          availableLanguages: availableLanguages,
        ),
    ]);
  }
}
