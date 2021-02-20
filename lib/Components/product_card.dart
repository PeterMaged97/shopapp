import 'package:flutter/material.dart';
import 'package:shopapp/Screens/product_details_page.dart';

class Product extends StatelessWidget {
  final String name;
  final String image;
  final int oldPrice;
  final int price;
  final int levelCounter;

  Product({this.levelCounter, this.name, this.image, this.oldPrice, this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductDetailsPage(
            levelCounter: levelCounter+1,
            productName: name,
            productPicture: image,
            productOldPrice: oldPrice,
            productNewPrice: price,
          )));
        },
        child: GridTile(
          child: Hero(tag: '$name$levelCounter', child: Image.asset(image, fit: BoxFit.cover)),
          footer: Container(
            alignment: Alignment.center,
            height:30,
            color: Color(0xB0000000),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(name, style: TextStyle(color: Colors.white)),
                Text('\$$oldPrice', style: TextStyle(color: Colors.grey, decoration: TextDecoration.lineThrough)),
                Text('\$$price', style: TextStyle(color: Colors.white)),
              ],
            )
          ),
        ),
      ),
    );
  }
}
