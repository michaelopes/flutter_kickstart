import 'package:flutter/material.dart';

import 'nested_json_parser.dart';

class AppLocalizations {
  AppLocalizations(this.locale, this.localizedValues);

  final Map<String, Map<String, dynamic>>? localizedValues;
  final Locale locale;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String? trans(
    String? key, {
    Map<String, String?>? params,
    String? defaultValue,
  }) {
    if (key == null) throw ArgumentError('key is null');

    var languageCode = locale.toString();
    var localizedValue = NestedJsonParser.resolve<String>(
      json: localizedValues![languageCode],
      path: key,
      defaultValue: defaultValue,
    );

    if (localizedValue == null) {
      return throw ArgumentError('key: $key not found in $languageCode.json');
    }

    if (params != null) {
      params.forEach((key, value) {
        localizedValue = localizedValue!.replaceAll('{{$key}}', value!);
      });
    }

    return localizedValue;
  }
}
