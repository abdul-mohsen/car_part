import 'package:car_part/common/extention/debug.dart';
import 'package:car_part/common/ui/view.dart';
import 'package:car_part/di/cache.dart';
import 'package:car_part/di/remote.dart';
import 'package:car_part/di/repository.dart';
import 'package:car_part/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:car_part/common/extention/list_extension.dart';
import 'package:logging/logging.dart';

void main() {
  setup();
  return runApp(ModularApp(module: AppModule(), child: MyApp()));
}

class AppModule extends Module {
  @override
  List<Bind> get binds => remoteInjection()
      .addAllAndReturn(cacheInjection())
      .addAllAndReturn(repositoryInjection());
  @override
  List<ModularRoute> get routes => [];
}

class MyApp extends StatelessWidget {
  final _router = AppRouter();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorObservers: [routeObserver],
      initialRoute: '/',
      onGenerateRoute: _router.route,
    );
  }
}

void setup() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((event) {
    debug("${event.level.name}: ${event.time}: ${event.message}");
  });
}
