import 'package:flutter/material.dart';
import 'package:taskproject/models/experience/experience.dart';
import 'package:taskproject/service/http_service.dart';
import 'package:taskproject/widgets/images/cached_images.dart';

class ItemExperienceHeader extends StatelessWidget {
  final Experience experience;

  const ItemExperienceHeader({Key key, this.experience}) : super(key: key);
  @override
  Widget build(BuildContext context) {  
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        CachedImages.getCompanyIcon(HttpService.getCompanyIconPath(experience.company.companyId), 40),
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(experience.company.companyName,
                  style: Theme.of(context)
                      .textTheme
                      .display1
                      .merge(TextStyle(fontWeight: FontWeight.w700))),
              Text('Test', style: Theme.of(context).textTheme.display1),
            ],
          ),
        )
      ],
    );
  }
}
