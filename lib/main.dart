import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/Screens/home_page.dart';
import 'package:shopapp/Screens/login.dart';
import 'package:shopapp/Screens/loading.dart';
import 'package:shopapp/Screens/signup.dart';
import 'package:shopapp/provider/product_provider.dart';
import 'package:shopapp/provider/user_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ShopApp());
}

class ShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider.initialize(),),
        ChangeNotifierProvider(create: (context) => ProductProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.red.shade900,
          cursorColor: Colors.red.shade900,
        ),
        routes: {
          '/': (context) => ScreenController(),
        },
      ),
    );
  }
}

class ScreenController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserProvider user = Provider.of<UserProvider>(context);
    switch(user.status){
      case Status.Unregistered:
        return SignUpScreen();
        break;
      case Status.Uninitialized:
      case Status.Unauthenticated:
        //ToDo: change this back to login screen after testing
        return HomePage();
        break;
      case Status.Authenticating:
        return Loading();
        break;
      case Status.Authenticated:
        return HomePage();
        break;
      default: return LoginScreen();
    }
  }
}

