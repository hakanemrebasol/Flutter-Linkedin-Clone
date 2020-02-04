import 'package:flutter/material.dart';

class ProgressWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Center(child: SizedBox(
      height: 25,
      width: 25,
      child: CircularProgressIndicator()));
  }
}