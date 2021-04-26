import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:convert';
import 'package:intl/intl_standalone.dart'
    if (dart.library.html) 'package:intl/intl_browser.dart';

List<Locale> appLocales = [
  Locale('en', 'US'),
];

const blablaDelegates = [
  Blabla.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
];

class Blabla {
  static const LocalizationsDelegate<Blabla> delegate = _BlablaDelegate();

  static Blabla of(BuildContext context) {
    return Localizations.of<Blabla>(context, Blabla);
  }

  static Blabla instance;

  Blabla() {
    instance = this;
  }

  Map<String, String> _localizedStrings;
  Map<String, String> _defaultStrings;

  Future<bool> _load() async {
    var _locale = await _getDeviceLocale();
    if (appLocales
        .map((appLocale) => appLocale.languageCode)
        .contains(_locale.languageCode)) {
      _localizedStrings = await _loadStrings(_locale);
    }
    _defaultStrings = await _loadStrings(appLocales.first);
    return true;
  }

  Future<Map<String, String>> _loadStrings(Locale locale) async {
    var jsonString =
        await rootBundle.loadString('language/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    var _decodedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
    return _decodedStrings;
  }

  Future<Locale> _getDeviceLocale() async {
    final _deviceLocale = await findSystemLocale();
    final _splittedLocale = _deviceLocale.split('_');
    final _deviceLanguageCode = _splittedLocale[0];
    final _deviceCountry = _splittedLocale[1];
    return Locale(_deviceLanguageCode, _deviceCountry);
  }

  String _translate(String key) {
    if (_localizedStrings != null && _localizedStrings[key] != null) {
      return _localizedStrings[key];
    }
    return _defaultStrings[key];
  }
}

class _BlablaDelegate extends LocalizationsDelegate<Blabla> {
  const _BlablaDelegate();

  @override
  bool isSupported(Locale locale) {
    return appLocales
        .map((appLocale) => appLocale.languageCode)
        .contains(locale.languageCode);
  }

  @override
  Future<Blabla> load(Locale locale) async {
    var translations = Blabla();
    await translations._load();
    return translations;
  }

  @override
  bool shouldReload(_BlablaDelegate old) => false;
}

String translate(String key) {
  return Blabla.instance._translate(key);
}
