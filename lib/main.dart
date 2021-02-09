import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/Screens/login.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ShopApp());
}

class ShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.red.shade900,
          cursorColor: Colors.red.shade900,
        ),
        routes: {
          '/' : (context) => LoginScreen(),
      },
    );
  }
}
