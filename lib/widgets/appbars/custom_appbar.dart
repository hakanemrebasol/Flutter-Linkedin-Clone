import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final IconData icon;

  const CustomAppBar({Key key, this.title, this.icon}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(title),
        leading: Icon(
          icon,
          color: Colors.white,
        ));
  }
}
