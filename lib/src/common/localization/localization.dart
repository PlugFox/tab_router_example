import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

import '../localization/generated/l10n.dart' as generated show GeneratedLocalization, AppLocalizationDelegate;

@sealed
class Localization extends generated.GeneratedLocalization {
  Localization._();
  static const LocalizationsDelegate<Localization> delegate = _LocalizationView(generated.AppLocalizationDelegate());
  static late Localization current;
  static List<Locale> get supportedLocales => const generated.AppLocalizationDelegate().supportedLocales;
}

@sealed
@immutable
class _LocalizationView extends LocalizationsDelegate<Localization> {
  @literal
  const _LocalizationView(
    LocalizationsDelegate<generated.GeneratedLocalization> delegate,
  ) : _delegate = delegate;

  final LocalizationsDelegate<generated.GeneratedLocalization> _delegate;

  @override
  bool isSupported(Locale locale) => _delegate.isSupported(locale);

  @override
  Future<Localization> load(Locale locale) =>
      generated.GeneratedLocalization.load(locale).then<Localization>((_) => Localization.current = Localization._());

  @override
  bool shouldReload(covariant _LocalizationView old) => false;
}
