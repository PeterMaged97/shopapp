import 'package:flutter/material.dart';
import 'package:shopapp/Screens/home_page.dart';

void main() {
  runApp(ShopApp());
}

class ShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/' : (context) => HomePage(),
      },
    );
  }
}
