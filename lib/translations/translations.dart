import 'package:i18n_extension/i18n_extension.dart';
import 'package:login/translations/es_mx.dart';
import 'package:login/translations/en_us.dart';

class TranslationsList {
  static var list = Translations.byLocale("en_us") +
      {
        "en_us": en_us,
      } +
      {
        "es_mx": es_mx,
      };
}
