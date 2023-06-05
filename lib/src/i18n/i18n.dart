import 'dart:async' show Future;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../setup/fk_globals.dart' as globals;

class I18n {
  I18n._internal();

  static final I18n I = I18n._internal();

  late final String filePath;
  final List<String> availableLanguages = <String>[];
  late final Locale defaultLocale;
  late final Map<String, Map<String, dynamic>> values;

  Iterable<Locale> get supportedLocales => availableLanguages.map((language) {
        var splt = language.split("_");
        return Locale(splt.first, splt.length == 2 ? splt.last : "");
      });

  Future<void> init({
    required String filePath,
    required List<String> availableLanguages,
    required Locale defaultLocale,
  }) async {
    if (globals.i18nDirectory.isNotEmpty && availableLanguages.isNotEmpty) {
      this.availableLanguages.clear();
      this.availableLanguages.addAll(availableLanguages);
      this.defaultLocale = defaultLocale;
      this.filePath = filePath;
      values = {};
      for (var language in availableLanguages) {
        Map<String, dynamic> translation =
            json.decode(await _loadJsonFromAsset(language));
        values[language] = _convertValueToString(translation);
      }
    }
  }

  Future<String> _loadJsonFromAsset(language) async {
    try {
      final bundle = _AssetBundle();
      return await bundle.loadString('$filePath$language.json');
    } on Exception {
      throw Exception('File "$language" not found $filePath');
    }
  }

  Map<String, dynamic> _convertValueToString(obj) {
    var result = <String, dynamic>{};
    obj.forEach((key, value) {
      result[key] = value;
    });
    return result;
  }
}

class _AssetBundle extends CachingAssetBundle {
  @override
  Future<String> loadString(String key, {bool cache = true}) async {
    final data = await load(key);
    return utf8.decode(data.buffer.asUint8List());
  }

  @override
  Future<ByteData> load(String key) async => rootBundle.load(key);
}
