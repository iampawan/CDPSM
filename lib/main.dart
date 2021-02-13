import 'package:flutter/material.dart';
import 'package:catalog_app/common/theme.dart';

import 'package:catalog_app/screens/cart.dart';
import 'package:catalog_app/screens/catalog.dart';
import 'package:catalog_app/screens/login.dart';
import 'package:provider/provider.dart';

import 'models/cart.dart';
import 'models/catalog.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => CatalogModel(),
        ),
        ChangeNotifierProxyProvider<CatalogModel, CartModel>(
            create: (context) => CartModel(),
            update: (context, catalog, cart) {
              cart.catalog = catalog;
              return cart;
            })
      ],
      child: MaterialApp(
        title: 'Codepur State Management',
        theme: appTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => MyLogin(),
          '/catalog': (context) => MyCatalog(),
          '/cart': (context) => MyCart(),
        },
      ),
    );
  }
}
