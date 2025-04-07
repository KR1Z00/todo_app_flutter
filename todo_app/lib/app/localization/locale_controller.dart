import 'package:flutter/widgets.dart';

import 'app_locales.dart';

class LocaleController {
  Locale getLocale() {
    return AppLocales.fallbackLocale;
  }
}
