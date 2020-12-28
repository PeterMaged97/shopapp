import 'package:flutter/material.dart';
import 'product.dart';

class ProductGrid extends StatelessWidget {
  final List productList = [
    {
      'name': 'Blazer',
      'image': 'images/products/blazer1.jpeg',
      'oldPrice': 120,
      'price': 100,
    },
    {
      'name': 'Dress',
      'image': 'images/products/dress1.jpeg',
      'oldPrice': 140,
      'price': 120,
    },
    {
      'name': 'Heels',
      'image': 'images/products/hills1.jpeg',
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
          name: productList[index]['name'],
          image: productList[index]['image'],
          oldPrice: productList[index]['oldPrice'],
          price: productList[index]['price'],
        );
      },
    );
  }
}
