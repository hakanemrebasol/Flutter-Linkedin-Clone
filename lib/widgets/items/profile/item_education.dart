import 'package:flutter/material.dart';
import 'package:taskproject/models/education/userEducation/user_education.dart';
import 'package:taskproject/service/http_service.dart';
import 'package:taskproject/util/date_extension.dart';
import 'package:taskproject/widgets/images/cached_images.dart';
import 'package:taskproject/widgets/mydivider.dart';

import '../../../router.dart';

class ItemEducation extends StatelessWidget {
  final UserEducation userEducation;

  const ItemEducation({Key key, this.userEducation}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, addEducationRoute,
            arguments: userEducation);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CachedImages.getCompanyIcon(
              HttpService.getEducationIconPath(
                  userEducation.education.educationId),
              40),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(userEducation.education.educationName,
                    style: Theme.of(context)
                        .textTheme
                        .display1
                        .merge(TextStyle(fontWeight: FontWeight.w700))),
                Text(
                    convertDateToFormat(
                            userEducation.startDate, ddMMyyyyFormat) +
                        " - " +
                        convertDateToFormat(
                            userEducation.endDate, ddMMyyyyFormat),
                    style: Theme.of(context).textTheme.display1),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Text(userEducation.description,
                      style: Theme.of(context).textTheme.display1),
                ),
                MyDivider()
              ],
            ),
          )
        ],
      ),
    );
  }
}
