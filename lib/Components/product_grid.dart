import 'package:flutter/material.dart';
import 'product_card.dart';
import 'package:shopapp/models/product.dart';


class ProductGrid extends StatefulWidget {

  ProductGrid(this.levelCounter, this.products);

  final int levelCounter;
  final List<Product> products;

  @override
  _ProductGridState createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      //physics: ScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: widget.products.length,
      gridDelegate:
      SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (BuildContext context, int index) {
        return ProductCard(
          levelCounter: widget.levelCounter,
          product: widget.products[index],
        );
      },
    );
  }
}
