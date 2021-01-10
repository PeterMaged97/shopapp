import 'package:flutter/material.dart';
import 'package:shopapp/Components/drawer_list_tile.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:shopapp/Components/horizontal_listview.dart';
import 'package:shopapp/Components/product_grid.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int levelCounter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('ShopApp'),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {}),
          IconButton(
            icon: Icon(Icons.shopping_cart, color: Colors.white),
            onPressed: () {},
          ),
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
            DrawerListTile(
              label: 'Home Page',
              icon: Icon(
                Icons.home,
                color: Colors.red,
              ),
              onTap: () {},
            ),
            DrawerListTile(
              label: 'My Account',
              icon: Icon(
                Icons.person,
                color: Colors.red,
              ),
              onTap: () {},
            ),
            DrawerListTile(
              label: 'My Orders',
              icon: Icon(
                Icons.shopping_basket,
                color: Colors.red,
              ),
              onTap: () {},
            ),
            DrawerListTile(
              label: 'Categories',
              icon: Icon(
                Icons.dashboard,
                color: Colors.red,
              ),
              onTap: () {},
            ),
            DrawerListTile(
              label: 'Favorites',
              icon: Icon(
                Icons.favorite,
                color: Colors.red,
              ),
              onTap: () {},
            ),
            Divider(),
            DrawerListTile(
              label: 'Settings',
              icon: Icon(
                Icons.settings,
                color: Colors.grey,
              ),
              onTap: () {},
            ),
            DrawerListTile(
              label: 'Help',
              icon: Icon(
                Icons.help,
                color: Colors.blue,
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 200,
            child: Carousel(
              boxFit: BoxFit.cover,
              autoplay: false,
              animationCurve: Curves.fastOutSlowIn,
              animationDuration: Duration(seconds: 1),
              dotSize: 4.0,
              dotColor: Colors.red[900],
              dotIncreasedColor: Colors.red,
              images: [
                AssetImage('images/c1.jpg'),
                AssetImage('images/IMG_1266.JPG'),
                AssetImage('images/m1.jpeg'),
                AssetImage('images/m2.jpg'),
                AssetImage('images/w1.jpeg'),
                AssetImage('images/w3.jpeg'),
                AssetImage('images/w4.jpeg'),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Categories'),
          ),
          HorizontalList(),
          Divider(),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Recent Products'),
          ),
          ProductGrid(levelCounter),
        ],
      ),
    );
  }
}
