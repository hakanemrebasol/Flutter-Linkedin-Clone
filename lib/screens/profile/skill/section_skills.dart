import 'package:flutter/material.dart';
import 'package:taskproject/models/skill/skill.dart';
import 'package:taskproject/widgets/chips/skill_clip.dart';

class SectionSkills extends StatefulWidget {
  final List<Skill> skilList;

  const SectionSkills({Key key, this.skilList}) : super(key: key);

  @override
  _SectionSkillsState createState() => _SectionSkillsState();
}

class _SectionSkillsState extends State<SectionSkills> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
        spacing: 4.0,
        runSpacing: -8.0,
        children: <Widget>[
          for (var item in widget.skilList)
            SkillChip(
              skill: item,
              onChanged: (value) {},
            )
        ],
      );
  }
}