import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('ShopApp'),
        actions: [
          IconButton(icon: Icon(Icons.search, color: Colors.white,), onPressed: (){}),
          IconButton(icon: Icon(Icons.shopping_cart, color: Colors.white), onPressed: (){}),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(accountName: Text('Name Here'), accountEmail: Text('name@example.com'))
          ],
        )
      ),
    );
  }
}
