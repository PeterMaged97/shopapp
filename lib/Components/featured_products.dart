import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/provider/product_provider.dart';

import 'featured_card.dart';

class FeaturedProducts extends StatefulWidget {

  final int levelCounter;

  const FeaturedProducts({Key key, this.levelCounter}) : super(key: key);

  @override
  _FeaturedProductsState createState() => _FeaturedProductsState();
}

class _FeaturedProductsState extends State<FeaturedProducts> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Container(
        height: MediaQuery.of(context).size.height/4,
        child: productProvider.featuredProducts.length == 0 ? Center(child: Text('No Featured Products')) : ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: productProvider.featuredProducts.length,
            itemBuilder: (_, index) {
              return FeaturedCard(
                product: productProvider.featuredProducts[index],
                levelCounter: widget.levelCounter,
              );
            }));
  }
}
