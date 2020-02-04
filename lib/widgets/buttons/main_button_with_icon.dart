import 'package:flutter/material.dart';
import 'package:taskproject/util/custom_colors.dart';

class MainButtonWithIcon extends StatelessWidget {
  final VoidCallback onPressButton;
  @required
  final String title;
  final IconData icon;
  final Color color;
  const MainButtonWithIcon({Key key, this.onPressButton, this.title, this.icon, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: color,
      focusElevation: 0,
      elevation: 0,
      highlightElevation: 0,
      disabledElevation: 0,
      hoverElevation: 0,
      onPressed: onPressButton,
      textColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      child: Container(
        padding: const EdgeInsets.fromLTRB(40, 12, 40, 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                title,
                style: Theme.of(context).textTheme.button,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
