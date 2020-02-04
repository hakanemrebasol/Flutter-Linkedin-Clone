import 'package:flutter/material.dart';
import 'package:taskproject/widgets/images/cached_images.dart';
import 'package:taskproject/widgets/mydivider.dart';

class ItemSearch extends StatelessWidget {
  final String imgUrl;
  final String text;

  const ItemSearch({Key key, this.imgUrl, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[CachedImages.getCompanyIcon(imgUrl, 40), Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(text),
            )],
          ),
          Divider(color: Colors.black26,)
        ],
      ),
    );
  }
}
