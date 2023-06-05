import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'app_localizations.dart';
import 'i18n.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return I18n.I.availableLanguages.contains(locale.toString());
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(
      AppLocalizations(locale, I18n.I.values),
    );
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
