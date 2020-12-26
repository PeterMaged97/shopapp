import 'package:flutter/material.dart';

class ListViewCategory extends StatelessWidget {
  final String imageLocation;
  final String imageCaption;

  ListViewCategory(this.imageLocation, this.imageCaption);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {},
        child: Container(
            width: 100.0,
            child: Column(
              children: [
                Image.asset(
                  imageLocation,
                  width: 100.0,
                  height: 70,
                ),
                SizedBox(height: 5,),
                Text(
                  imageCaption,
                  style: TextStyle(color: Colors.red[900]),
                  textAlign: TextAlign.center,
                ),
              ],
            )
            // child: ListTile(
            //   title: Image.asset(
            //     imageLocation,
            //     width: 100.0,
            //     height: 80,
            //   ),
            //   subtitle: Container(
            //     alignment: Alignment.topCenter,
            //     child: Text(
            //       imageCaption,
            //       style: TextStyle(color: Colors.red),
            //       //textAlign: TextAlign.center,
            //     ),
            //   ),
            // ),
            ),
      ),
    );
  }
}
