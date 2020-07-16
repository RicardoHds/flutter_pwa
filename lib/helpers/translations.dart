import 'package:i18n_extension/i18n_extension.dart';
import 'package:login/translations/translations.dart';

extension Localization on String {
  static var _t = TranslationsList.list;

  String get i18n => localize(this, _t);

  String fill(List<Object> params) => localizeFill(this, params);

  String plural(int value) => localizePlural(value, this, _t);

  String version(Object modifier) => localizeVersion(modifier, this, _t);

  Map<String, String> allVersions() => localizeAllVersions(this, _t);
}
