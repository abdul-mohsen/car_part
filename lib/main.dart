import 'package:car_part/common/cache/app_pref.dart';
import 'package:car_part/common/cache/database/database.dart';
import 'package:car_part/common/extention/debug.dart';
import 'package:car_part/common/routing/main_route.dart';
import 'package:car_part/di/cache.dart';
import 'package:car_part/di/remote.dart';
import 'package:car_part/di/repository.dart';
import 'package:car_part/di/view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:car_part/common/extention/list_extension.dart';
import 'package:logging/logging.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:car_part/common/extention/any_extension.dart';

void main() {
  setup();
  return runApp(ModularApp(module: AppModule(), child: const MyApp()));
}

class AppModule extends Module {
  @override
  List<Bind> get binds =>
      remoteInjection().addAllAndReturn(cacheInjection()).addAllAndReturn(
          repositoryInjection().addAllAndReturn(viewModelInjection()));
  @override
  List<ModularRoute> get routes => mainRoute();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => StreamBuilder(
      initialData: null,
      stream: Modular.get<AppPref>().getStringRx(AppPref.locale),
      builder: (context, localeSnapshot) => MaterialApp.router(
          title: 'My Smart App',
          theme: ThemeData(primarySwatch: Colors.blue),
          routeInformationParser: Modular.routeInformationParser,
          routerDelegate: Modular.routerDelegate,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            // delegate from flutter_localization
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
          locale: localeSnapshot.data?.let((it) => Locale(it.to())),
          localeListResolutionCallback: (locales, supportedLocales) {
            debug(
                'device locales=$locales supported locales=$supportedLocales');

            for (Locale locale in locales.or([])) {
              // if device language is supported by the app,
              // just return it to set it as current app language
              if (supportedLocales.contains(locale)) {
                return locale;
              }
            }

            // if device language is not supported by the app,
            // the app will set it to english but return this to set to Bahasa instead
            return const Locale('en');
          },
          supportedLocales: const [
            Locale('ar'),
            Locale('en')
          ])); //added by extension
}

void setup() {
  WidgetsFlutterBinding.ensureInitialized();
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((event) {
    debug("${event.level.name}: ${event.time}: ${event.message}");
  });
}
