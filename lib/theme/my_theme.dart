import 'package:flutter/material.dart';
import 'package:taskproject/util/custom_colors.dart';
import 'package:taskproject/util/dimens.dart';

class MyTheme {
  static getTheme() {
    return new ThemeData(
        //brightness: Brightness.dark,
        fontFamily: 'Rubik',
        primaryColor: CustomColors.colorPrimary,
        accentColor: CustomColors.accentColor,
        textTheme: TextTheme(
          button: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: Dimens.normalText,
              color: Colors.white),
          title: TextStyle(
              fontWeight: FontWeight.w500, fontSize: Dimens.largeText),
          display1: TextStyle(fontSize: Dimens.smallText),
          display2: TextStyle(fontSize: Dimens.normalText),
          display3: TextStyle(fontSize: Dimens.largeText),
        ));
  }
}
