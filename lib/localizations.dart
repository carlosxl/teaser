import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'l10n/messages_all.dart';

class AppLocalizations {
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(
      context,
      AppLocalizations,
    );
  }

  String get appTitle => Intl.message(
        '我的应用',
      );

  String get title => Intl.message(
        '金汇行情',
      );

  String get highPrice => Intl.message(
        '最高价',
      );

  String get lowPrice => Intl.message(
        '最低价',
      );
}

class AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  @override
  Future<AppLocalizations> load(Locale locale) {
    final String name = locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return AppLocalizations();
    });
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;

  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);
}
