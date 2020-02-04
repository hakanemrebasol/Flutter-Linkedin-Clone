import 'package:flutter/material.dart';
import 'package:taskproject/models/experience/experience.dart';
import 'package:taskproject/router.dart';
import 'package:taskproject/util/date_extension.dart';

class ItemExperienceChild extends StatelessWidget {
  final Experience experience;
  final isLast;
  const ItemExperienceChild({Key key, this.experience, this.isLast})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, addExperienceRoute, arguments: experience);
      },
      child: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 4),
                  child: CircleAvatar(
                    maxRadius: 3,
                    minRadius: 3,
                    backgroundColor: Colors.black.withOpacity(0.2),
                  ),
                ),
                if (!isLast)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Container(
                      height: 50,
                      color: Colors.black.withOpacity(0.2),
                      width: 2,
                    ),
                  )
              ]),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(experience.title,
                          style: Theme.of(context)
                              .textTheme
                              .display1
                              .merge(TextStyle(fontWeight: FontWeight.w700))),
                      Text(
                          convertDateToFormat(
                                  experience.startDate, ddMMyyyyFormat) +
                              " - " +
                              convertDateToFormat(
                                  experience.endDate, ddMMyyyyFormat),
                          style: Theme.of(context).textTheme.display1),
                      Text(experience.location,
                          style: Theme.of(context).textTheme.display1),
                      Text(experience.description,
                          style: Theme.of(context).textTheme.display1),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
