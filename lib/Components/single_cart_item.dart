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
      // child: ListTile(
      //   leading: SizedBox(
      //     child: Image.asset(
      //       image,
      //     ),
      //     width: 50,
      //   ),
      //   title: Text(name),
      //   subtitle: Row(
      //     children: [
      //       Column(
      //         crossAxisAlignment: CrossAxisAlignment.end,
      //         children: [
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //             children: [
      //               Row(
      //                 children: [
      //                   Text('Size: '),
      //                   Text(
      //                     size,
      //                     style: TextStyle(color: Colors.red),
      //                   ),
      //                 ],
      //               ),
      //               Row(
      //                 children: [
      //                   Text('Color: '),
      //                   Text(
      //                     color,
      //                     style: TextStyle(color: Colors.red),
      //                   ),
      //                 ],
      //               )
      //             ],
      //           ),
      //           Padding(
      //             padding: const EdgeInsets.only(top: 8.0),
      //             child: Text(
      //               '${qty.toString()} x \$${price.toString()}',
      //               style: TextStyle(
      //                 color: Colors.red,
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //       Column(
      //         children: [
      //           IconButton(
      //             icon: Icon(Icons.arrow_drop_up),
      //             onPressed: () {},
      //           ),
      //           Text(
      //             qty.toString(),
      //           ),
      //           IconButton(
      //             icon: Icon(Icons.arrow_drop_down),
      //             onPressed: () {},
      //           ),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
      child: Container(
        height: 100,
        child: Row(
          children: [
            Expanded(
                child: Container(
              child: Image.asset(image),
              width: 100,
            )),
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(name,
                          style:
                              TextStyle(fontWeight: FontWeight.w500, fontSize: 17)),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Text('Size: '),
                          Text(size, style: TextStyle(color:Colors.red))
                        ],
                      ),
                      Row(
                        children: [
                          Text('Color: '),
                          Text(color, style: TextStyle(color: Colors.red))
                        ],
                      ),
                    ],
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('${qty.toString()} x ',),
                          Text('\$${price.toString()}', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20),)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Flexible(
                    child: IconButton(
                      icon: Icon(Icons.arrow_drop_up),
                      onPressed: () {},
                    ),
                  ),
                  Text(
                    qty.toString(),
                  ),
                  Flexible(
                    child: IconButton(
                      icon: Icon(Icons.arrow_drop_down),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
