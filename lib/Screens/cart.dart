import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopapp/Components/single_cart_item.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {

  List cartItemsList = [
    {
      'name': 'Blazer1',
      'image': 'images/products/blazer1.jpeg',
      'price': 100,
      'color': 'Brown',
      'size': 'M',
      'qty': 1
    },
    {
      'name': 'Blazer2',
      'image': 'images/products/blazer2.jpeg',
      'price': 120,
      'color': 'Black',
      'size': 'L',
      'qty': 2
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Cart'),
        centerTitle: true,
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: ListTile(
                title: Text('Total:'),
                subtitle: Text('\$${cartItemsList.reduce((value, element) => value['price']*value['qty'] + element['price']*element['qty'])}'),
              )
            ),
            Expanded(
              child: MaterialButton(
                onPressed: (){},
                child: Text('Check Out', style: TextStyle(color: Colors.white),),
                color: Colors.red,
              )
            ),
          ],
        )
      ),
      body: ListView.builder(
          itemCount: cartItemsList.length,
          itemBuilder: (context, index){
            return SingleCartItem(
              name: cartItemsList[index]['name'],
              image: cartItemsList[index]['image'],
              color: cartItemsList[index]['color'],
              size: cartItemsList[index]['size'],
              price: cartItemsList[index]['price'],
              qty: cartItemsList[index]['qty'],
            );
      })
    );
  }
}
