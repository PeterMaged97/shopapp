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
          child: Column(
            children: [
              Image.asset(imageLocation, height: 80,),
              Text(
                imageCaption,
                style: TextStyle(color: Colors.red[900]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
