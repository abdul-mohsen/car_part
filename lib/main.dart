import 'package:car_part/common/extention/debug.dart';
import 'package:car_part/common/routing/main_route.dart';
import 'package:car_part/di/cache.dart';
import 'package:car_part/di/remote.dart';
import 'package:car_part/di/repository.dart';
import 'package:car_part/di/view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:car_part/common/extention/list_extension.dart';
import 'package:logging/logging.dart';

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
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'My Smart App',
      theme: ThemeData(primarySwatch: Colors.blue),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    ); //added by extension
  }
}

void setup() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((event) {
    debug("${event.level.name}: ${event.time}: ${event.message}");
  });
}
