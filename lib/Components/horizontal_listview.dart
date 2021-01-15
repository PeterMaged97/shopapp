import 'package:flutter/material.dart';
import 'file:///G:/HDD/FlutterProjects/shopapp/lib/Components/listview_category.dart';

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
       height: 100.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          ListViewCategory('images/cats/tshirt.png', 'Shirts'),
          ListViewCategory('images/cats/dress.png', 'Dresses'),
          ListViewCategory('images/cats/jeans.png', 'Jeans'),
          ListViewCategory('images/cats/shoe.png', 'Shoes'),
          ListViewCategory('images/cats/formal.png', 'Formal'),
          ListViewCategory('images/cats/informal.png', 'Informal'),
          ListViewCategory('images/cats/accessories.png', 'Accessories'),
        ],
      ),
    );
  }
}
