import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_kickstart/flutter_kickstart.dart';
import 'package:flutter_kickstart/src/model/fk_font.dart';

import '../i18n/i18n.dart';
import 'fk_infos.dart';
import 'fk_load_font.dart';

import 'fk_globals.dart' as globals;

class Fk {
  static Future<dynamic> init({
    String env = "",
    String i18nDirectory = "",
    Locale defaultLocale = const Locale("en"),
    List<FkFont> fonts = const [],
    List<Future> extraInits = const [],
    List<String> availableLanguages = const [],
    FkBaseHttpDriverResponseParser? httpDriverResponseParser,
    bool enableHttpDriverLogger = true,
    FkHttpDriverMiddleware? httpDriverMiddleware,
    FkModuleMiddleware? moduleMiddleware,
    String baseUrl = "",
  }) async {
    WidgetsFlutterBinding.ensureInitialized();

    globals.i18nDirectory = i18nDirectory;

    globals.enableHttpDriverLogger = enableHttpDriverLogger;
    globals.baseUrl = baseUrl;

    if (httpDriverResponseParser != null) {
      globals.httpDriverResponseParser = httpDriverResponseParser;
    }

    if (httpDriverMiddleware != null) {
      globals.httpDriverMiddleware = httpDriverMiddleware;
    }

    globals.moduleMiddleware = moduleMiddleware;

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
