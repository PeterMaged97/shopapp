import 'package:flutter/material.dart';
import 'package:shopapp/Screens/product_details_page.dart';
import 'package:shopapp/models/product.dart';

class ProductCard extends StatelessWidget {
  final int levelCounter;
  final Product product;

  const ProductCard({this.product, this.levelCounter});


  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductDetailsPage(
            levelCounter: levelCounter+1,
            product: product,
          )));
        },
        child: GridTile(
          child: Hero(tag: '${product.name}$levelCounter', child: Image.network(product.image, fit: BoxFit.cover)),
          footer: Container(
            alignment: Alignment.center,
            height:30,
            color: Color(0xB0000000),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(product.name, style: TextStyle(color: Colors.white)),
                Text('\$${product.price}', style: TextStyle(color: Colors.white)),
              ],
            )
          ),
        ),
      ),
    );
  }
}
