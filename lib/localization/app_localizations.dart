import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  // Add your localized strings here
  String get helloWorld {
    switch (locale.languageCode) {
      case 'en':
        return 'Hello World!';
      case 'pl':
        return 'Witaj świecie!';
      default:
        return 'Hello World!';
    }
  }

  // Add more localized strings as needed
  String get loginTitle {
    switch (locale.languageCode) {
      case 'en':
        return 'Login';
      case 'pl':
        return 'Logowanie';
      default:
        return 'Login';
    }
  }

  String get dashboardTitle {
    switch (locale.languageCode) {
      case 'en':
        return 'Dashboard';
      case 'pl':
        return 'Panel';
      default:
        return 'Dashboard';
    }
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // Add supported locales here
    return ['en', 'pl'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
