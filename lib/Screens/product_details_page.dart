import 'package:flutter/material.dart';
import 'package:shopapp/Components/order_details_button.dart';
import 'package:shopapp/Components/product_grid.dart';
import 'package:shopapp/models/product.dart';

class ProductDetailsPage extends StatefulWidget {
  final Product product;
  final int levelCounter;

  ProductDetailsPage(
      {this.levelCounter,
      this.product});

  @override
  _ProductDetailsPageState createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: InkWell(
          child: Text('ShopApp'),
          onTap: () {
            Navigator.popUntil(context, ModalRoute.withName('/'));
          },
        ),
        centerTitle: true,
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
                    tag: '${widget.product.name}${widget.levelCounter-1}',
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
          //-------------Order Details Buttons-----------------
          Row(children: [
            OrderDetailsButton(label: 'Size', color: Colors.black),
            OrderDetailsButton(label: 'Color', color: Colors.black),
            OrderDetailsButton(label: 'Quantity', color: Colors.black),
          ]),
          //--------------Buy Now Button---------------------
          Row(
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
                    height: 30,
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
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: ListTile(
              title: Text('Product Details'),
              subtitle: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Felis bibendum ut tristique et egestas. Id aliquet risus feugiat in ante metus dictum. Commodo viverra maecenas accumsan lacus vel facilisis volutpat. Sit amet consectetur adipiscing elit duis tristique sollicitudin. Nisl tincidunt eget nullam non nisi. Bibendum arcu vitae elementum curabitur vitae nunc sed. Interdum varius sit amet mattis. Et molestie ac feugiat sed lectus vestibulum mattis. Malesuada nunc vel risus commodo viverra maecenas accumsan lacus.'),
            ),
          ),
          Divider(
            thickness: 1,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Text(
                    'Product Name: ',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    widget.product.name,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Product Condition: ',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    'NEW',
                  ),
                ],
              ),
            ],
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text('Similar Products'),
          // ),
          //ProductGrid(widget.levelCounter),
        ],
      ),
    );
  }
}
