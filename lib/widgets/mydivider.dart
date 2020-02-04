import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black38.withOpacity(.1),
      height: 1,
     width: MediaQuery.of(context).size.width/1.4
    );
  }
}