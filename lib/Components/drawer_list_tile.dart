import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {

  final String label;
  final Icon icon;
  final Function onTap;

  DrawerListTile({this.label, this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        title: Text(label),
        leading: icon,
      ),
    );
  }
}