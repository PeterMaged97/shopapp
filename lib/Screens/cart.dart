import 'package:flutter/material.dart';

class Cart extends StatelessWidget {
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
                title: Text('Total'),
                subtitle: Text('\$230'),
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
    );
  }
}
