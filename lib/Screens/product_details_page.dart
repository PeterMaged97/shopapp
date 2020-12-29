import 'package:flutter/material.dart';
import 'package:shopapp/Components/order_details_button.dart';

class ProductDetailsPage extends StatefulWidget {
  final String productName;
  final String productPicture;
  final int productOldPrice;
  final int productNewPrice;

  ProductDetailsPage(
      {this.productName,
      this.productPicture,
      this.productOldPrice,
      this.productNewPrice});

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
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
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            height: 300.0,
            child: GridTile(
              child: Container(
                child: Hero(
                    tag: widget.productName,
                    child: Image.asset(widget.productPicture)),
              ),
              footer: Container(
                  alignment: Alignment.center,
                  height: 30,
                  color: Color(0xB0000000),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(widget.productName,
                          style: TextStyle(color: Colors.white)),
                      Text('\$${widget.productOldPrice}',
                          style: TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough)),
                      Text('\$${widget.productNewPrice}',
                          style: TextStyle(color: Colors.white)),
                    ],
                  )),
            ),
          ),
          //-------------Order Details Buttons-----------------
          Row(children: [
            OrderDetailsButton(label: 'Size', color: Colors.black),
            OrderDetailsButton(label: 'Color', color: Colors.black),
            OrderDetailsButton(label: 'Quantity', color: Colors.black),
          ]),
          //--------------Buy Now Button---------------------
          Row(children: [
            Expanded(
              child: MaterialButton(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0)),
                onPressed: () {},
                color: Colors.red,
                textColor: Colors.white,
                elevation: 2.0,
                child: Center(
                  child: Text('Buy Now'),
                ),
              ),
            )
          ],)
        ],
      ),
    );
  }
}
