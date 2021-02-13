import 'package:flutter/material.dart';
import 'package:catalog_app/common/theme.dart';

import 'package:catalog_app/screens/cart.dart';
import 'package:catalog_app/screens/catalog.dart';
import 'package:catalog_app/screens/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO 1 - Add a wrapper
    return MaterialApp(
      title: 'Codepur State Management',
      theme: appTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => MyLogin(),
        '/catalog': (context) => MyCatalog(),
        '/cart': (context) => MyCart(),
      },
    );
  }
}
