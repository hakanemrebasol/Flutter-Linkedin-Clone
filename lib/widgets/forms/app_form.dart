import 'package:flutter/material.dart';
import 'package:taskproject/util/custom_colors.dart';
import 'package:taskproject/util/dimens.dart';

class AppForm extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obscureText;

  const AppForm({Key key, this.label, this.controller, this.obscureText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.title.merge(TextStyle(
           )),
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          labelText: label,
          alignLabelWithHint: true,
          labelStyle: Theme.of(context).textTheme.display3.merge(TextStyle(
              )),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: CustomColors.colorPrimary),
          ),

          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: CustomColors.colorPrimary),
          )),
    );
  }
}
