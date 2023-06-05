import 'package:flutter/material.dart';

import 'app_localizations.dart';

class AppTranslate {
  static String tr(String key, BuildContext context,
      {Map<String, String>? params, String defaultValue = ''}) {
    var lc = AppLocalizations.of(context);
    return (lc?.trans(key, params: params, defaultValue: defaultValue) ?? '');
  }
}
