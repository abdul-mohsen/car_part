import 'package:flutter/cupertino.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension Context on BuildContext {
  AppLocalizations getStrings() => AppLocalizations.of(this)!;
}
