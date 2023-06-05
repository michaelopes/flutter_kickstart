import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_kickstart/src/model/fk_font.dart';

import '../i18n/i18n.dart';
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
  }) async {
    WidgetsFlutterBinding.ensureInitialized();

    globals.animationsDirectory = animationsDirectory;
    globals.imagesDirectory = imagesDirectory;
    globals.iconsDirectory = iconsDirectory;
    globals.i18nDirectory = i18nDirectory;

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
