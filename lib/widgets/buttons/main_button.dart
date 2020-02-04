import 'package:flutter/material.dart';
import 'package:taskproject/util/custom_colors.dart';

class MainButton extends StatelessWidget {
  final VoidCallback onPressButton;
  @required
  final String title;

  const MainButton({Key key, this.onPressButton, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: CustomColors.colorPrimary,
      focusElevation: 0,
      elevation: 0,
      highlightElevation: 0,
      disabledElevation: 0,
      hoverElevation: 0,
      onPressed: onPressButton,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: Container(
        padding: const EdgeInsets.fromLTRB(80, 18, 80, 18),
        child: Text(title, style: Theme.of(context).textTheme.button,),
      ),
    );
  }
}
