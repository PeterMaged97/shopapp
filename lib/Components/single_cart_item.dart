import 'package:flutter/material.dart';

class SingleCartItem extends StatelessWidget {
  final String name;
  final String image;
  final int price;
  final String size;
  final String color;
  final int qty;

  SingleCartItem(
      {this.name, this.image, this.price, this.size, this.color, this.qty});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: SizedBox(
          child: Image.asset(
            image,
          ),
          width: 50,
        ),
        title: Text(name),
        subtitle: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Text('Size: '),
                        Text(
                          size,
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Color: '),
                        Text(
                          color,
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    '${qty.toString()} x \$${price.toString()}',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_drop_up),
                  onPressed: () {},
                ),
                Text(
                  qty.toString(),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_drop_down),
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
