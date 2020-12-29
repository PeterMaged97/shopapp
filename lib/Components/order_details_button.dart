import 'package:flutter/material.dart';

class OrderDetailsButton extends StatelessWidget {

  final String label;
  final Color color;

  OrderDetailsButton({this.label, this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MaterialButton(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0)),
        onPressed: () {},
        color: color,
        textColor: Colors.white,
        elevation: 2.0,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [Text(label), Icon(Icons.arrow_drop_down)],
          ),
        ),
      ),
    );
  }
}
