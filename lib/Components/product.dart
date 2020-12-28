import 'package:flutter/material.dart';

class Product extends StatelessWidget {
  final String name;
  final String image;
  final int oldPrice;
  final int price;

  Product({this.name, this.image, this.oldPrice, this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag: name,
        child: InkWell(
          onTap: () {},
          child: GridTile(
            child: Image.asset(image, fit: BoxFit.cover),
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
      ),
    );
  }
}
