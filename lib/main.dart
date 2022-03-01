import 'package:car_part/commen/ui/View.dart';
import 'package:car_part/di/cache.dart';
import 'package:car_part/di/remote.dart';
import 'package:car_part/di/repository.dart';
import 'package:car_part/features/carPart/data/remote/data/response/api_car_part_auto_complete.dart';
import 'package:car_part/features/carPart/data/remote/source/car_part_client.dart';
import 'package:car_part/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;
import 'package:car_part/commen/extention/list_extention.dart';
import 'package:logging/logging.dart';

class Product {
  const Product({required this.name});

  final String name;
}

typedef CartChangedCallback = Function(Product product, bool inCart);

class ShoppingListItem extends StatelessWidget {
  ShoppingListItem({
    required this.product,
    required this.inCart,
    required this.onCartChanged,
  }) : super(key: ObjectKey(product));

  final Product product;
  final bool inCart;
  final CartChangedCallback onCartChanged;

  Color _getColor(BuildContext context) {
    // The theme depends on the BuildContext because different
    // parts of the tree can have different themes.
    // The BuildContext indicates where the build is
    // taking place and therefore which theme to use.

    return inCart //
        ? Colors.black54
        : Theme.of(context).primaryColor;
  }

  TextStyle? _getTextStyle(BuildContext context) {
    if (!inCart) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onCartChanged(product, inCart);
        Modular.get<CarPartClient>().getCarPartAutoCompleteList("");
      },
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        child: Text(product.name[0]),
      ),
      title: Text(product.name, style: _getTextStyle(context)),
    );
  }
}

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

Future<http.Response> fetchAlbum() {
  return http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));
}

MaterialApp temp() {
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: ShoppingListItem(
          product: const Product(name: 'Chips'),
          inCart: true,
          onCartChanged: (product, inCart) {},
        ),
      ),
    ),
  );
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
    print("${event.level.name}: ${event.time}: ${event.message}");
  });
}
