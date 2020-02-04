import 'package:flutter/material.dart';
import 'package:taskproject/models/experience/experience.dart';
import 'package:taskproject/widgets/items/profile/item_experience_child.dart';
import 'package:taskproject/widgets/items/profile/item_experience_header.dart';

class SectionExperiences extends StatefulWidget {
  final List<Experience> experienceList;

  const SectionExperiences({Key key, this.experienceList}) : super(key: key);

  @override
  _SectionExperiencesState createState() => _SectionExperiencesState();
}

class _SectionExperiencesState extends State<SectionExperiences> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: widget.experienceList.length,
      itemBuilder: (context, pos) {
        if (pos != 0 &&
            widget.experienceList[pos].company.companyId ==
                widget.experienceList[pos - 1].company.companyId) {
          return Padding(
            padding: const EdgeInsets.only(top: 16),
            child: ItemExperienceChild(
              isLast: false,
              experience: widget.experienceList[pos],
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Column(
            children: <Widget>[
              ItemExperienceHeader(
                experience: widget.experienceList[pos],
              ),
              ItemExperienceChild(
                isLast: false,
                experience: widget.experienceList[pos],
              ),
            ],
          ),
        );
      },
    );
  }
}
