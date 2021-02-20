import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/Components/order_details_button.dart';
import 'package:shopapp/Components/product_grid.dart';
import 'package:shopapp/models/product.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;
  final int levelCounter;

  ProductDetailsPage({this.levelCounter, this.product});

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  String selectedSize;

  @override
  void initState() {
    super.initState();
    selectedSize = widget.product.sizes[0];
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        body: Stack(
          children: [
            ListView(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height/2,
                  child: GridTile(
                    child: Container(
                      child: Hero(
                          tag: '${widget.product.name}${widget.levelCounter - 1}',
                          child: Image.network(widget.product.image)),
                    ),
                    footer: Container(
                        alignment: Alignment.center,
                        height: 30,
                        color: Color(0xB0000000),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(widget.product.name,
                                style: TextStyle(color: Colors.white)),
                            Text('\$${widget.product.price}',
                                style: TextStyle(color: Colors.white)),
                          ],
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: ListTile(
                    title: Text(
                      'Product Details',
                      style: TextStyle(fontSize: 20),
                    ),
                    subtitle: Text(
                      '\nProduct Name: ${widget.product.name}\n'
                      'Brand: ${widget.product.brand}\n'
                      'Category: ${widget.product.category}\n'
                      'Price: \$${widget.product.price}\n'
                      'Quantity Available: ${widget.product.quantity.toString()}\n'
                      'Available Sizes: ${widget.product.sizes.map((e) => ' $e ')}',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                Divider(
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text('Select a size'),
                      Container(
                        height: MediaQuery.of(context).size.height / 25,
                        child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: widget.product.sizes
                                .map(
                                  (value) => Container(
                                    //width: 50,
                                    child: Row(
                                      children: [
                                        Radio(
                                          groupValue: selectedSize,
                                          value: value,
                                          onChanged: (val) {
                                            setState(() {
                                              selectedSize = val;
                                            });
                                          },
                                        ),
                                        Text(value),
                                      ],
                                    ),
                                  ),
                                )
                                .toList()),
                      )
                    ],
                  ),
                ),
              ],
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0)),
                      onPressed: () {},
                      color: Colors.red,
                      textColor: Colors.white,
                      elevation: 2.0,
                      child: Container(
                        height: 50,
                        child: Center(
                          child: Row(
                            children: [
                              Expanded(
                                child: Center(child: Text('Buy Now')),
                                flex: 8,
                              ),
                              Expanded(
                                child: IconButton(
                                    icon: Icon(Icons.add_shopping_cart),
                                    onPressed: () {}),
                                flex: 1,
                              ),
                              Expanded(
                                  child: IconButton(
                                      icon: Icon(Icons.favorite_border),
                                      onPressed: () {}),
                                  flex: 1)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SafeArea(
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(icon: Icon(Icons.close), onPressed: () {
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                },),
              ),
            )
          ],
        ),
      ),
    );
  }
}
