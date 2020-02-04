import 'package:flutter/material.dart';
import 'package:taskproject/models/education/userEducation/user_education.dart';
import 'package:taskproject/widgets/items/profile/item_education.dart';

class SectionEducation extends StatefulWidget {
  final List<UserEducation> userEducationList;

  const SectionEducation({Key key, this.userEducationList}) : super(key: key);

  @override
  _SectionEducationState createState() => _SectionEducationState();
}

class _SectionEducationState extends State<SectionEducation> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
                primary: false,
                shrinkWrap: true,
                itemCount: widget.userEducationList.length,
                itemBuilder: (context, pos) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 4),
                    child: ItemEducation(
                      userEducation: widget.userEducationList[pos],
                    ),
                  );
                },
              );
  }
}