import 'package:flutter/material.dart';
import 'package:shopapp/Components/drawer_list_tile.dart';

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
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {}),
          IconButton(
              icon: Icon(Icons.shopping_cart, color: Colors.white),
              onPressed: () {}),
        ],
      ),
      drawer: Drawer(
          child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Name'),
              accountEmail: Text('name@example.com'),
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                  backgroundColor: Colors.red[900],
                  child: Icon(Icons.person, color: Colors.black),
                ),
              ),
              decoration: BoxDecoration(color: Colors.red),
            ),
            DrawerListTile(label: 'Home Page', icon: Icon(Icons.home, color: Colors.red,), onTap: (){},),
            DrawerListTile(label: 'My Account', icon: Icon(Icons.person, color: Colors.red,), onTap: (){},),
            DrawerListTile(label: 'My Orders', icon: Icon(Icons.shopping_basket, color: Colors.red,), onTap: (){},),
            DrawerListTile(label: 'Categories', icon: Icon(Icons.dashboard, color: Colors.red,), onTap: (){},),
            DrawerListTile(label: 'Favorites', icon: Icon(Icons.favorite, color: Colors.red,), onTap: (){},),
            Divider(),
            DrawerListTile(label: 'Settings', icon: Icon(Icons.settings, color: Colors.grey,), onTap: (){},),
            DrawerListTile(label: 'Help', icon: Icon(Icons.help, color: Colors.blue,), onTap: (){},),
          ],
      )),
    );
  }
}
