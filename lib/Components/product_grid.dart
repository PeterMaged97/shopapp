import 'package:flutter/material.dart';
import 'product.dart';

class ProductGrid extends StatefulWidget {

  ProductGrid(this.levelCounter);

  final int levelCounter;

  @override
  _ProductGridState createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
  final List productList = [
    {
      'name': 'Blazer1',
      'image': 'images/products/blazer1.jpeg',
      'oldPrice': 120,
      'price': 100,
    },
    {
      'name': 'Blazer2',
      'image': 'images/products/blazer2.jpeg',
      'oldPrice': 140,
      'price': 120,
    },
    {
      'name': 'Dress1',
      'image': 'images/products/dress1.jpeg',
      'oldPrice': 80,
      'price': 50,
    },
    {
      'name': 'Dress2',
      'image': 'images/products/dress2.jpeg',
      'oldPrice': 80,
      'price': 50,
    },
    {
      'name': 'Heels1',
      'image': 'images/products/hills1.jpeg',
      'oldPrice': 80,
      'price': 50,
    },
    {
      'name': 'Heels2',
      'image': 'images/products/hills2.jpeg',
      'oldPrice': 80,
      'price': 50,
    },
    {
      'name': 'Pants1',
      'image': 'images/products/pants1.jpg',
      'oldPrice': 80,
      'price': 50,
    },
    {
      'name': 'Pants2',
      'image': 'images/products/pants2.jpeg',
      'oldPrice': 80,
      'price': 50,
    },
    {
      'name': 'Skirt1',
      'image': 'images/products/skt1.jpeg',
      'oldPrice': 80,
      'price': 50,
    },
    {
      'name': 'Skirt2',
      'image': 'images/products/skt2.jpeg',
      'oldPrice': 80,
      'price': 50,
    },
    {
      'name': 'Shoes',
      'image': 'images/products/shoe1.jpg',
      'oldPrice': 80,
      'price': 50,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: ScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: productList.length,
      gridDelegate:
      SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return Product(
          levelCounter: widget.levelCounter,
          name: productList[index]['name'],
          image: productList[index]['image'],
          oldPrice: productList[index]['oldPrice'],
          price: productList[index]['price'],
        );
      },
    );
  }
}
