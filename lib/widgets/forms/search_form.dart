import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:taskproject/util/custom_colors.dart';
import 'package:taskproject/util/dimens.dart';
import 'package:taskproject/widgets/images/cached_images.dart';

class SearchForm extends StatefulWidget {
  final String hint;
  final VoidCallback onPress;
  final String imgUrl;

  const SearchForm({Key key, this.hint, this.onPress, this.imgUrl})
      : super(key: key);

  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onPress();
      },
      child: SizedBox(
        width: double.infinity,
        child: Container(
              decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50)),
        border: Border.all(width: 1, color: CustomColors.colorPrimary.withOpacity(0.4))),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          widget.imgUrl == null
              ? Icon(Icons.search, color: CustomColors.colorPrimary)
              : CachedImages.getCompanyIcon(widget.imgUrl, 40),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(widget.hint,
                style: Theme.of(context).textTheme.title.merge(
                    TextStyle(color: CustomColors.colorPrimary,fontSize: Dimens.smallText))),
          ),
        ],
                ),
              )),
      ),
    );
  }
}
