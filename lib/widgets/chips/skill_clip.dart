import 'package:flutter/material.dart';
import 'package:taskproject/models/skill/skill.dart';
import 'package:taskproject/util/custom_colors.dart';

class SkillChip extends StatelessWidget {
  final Skill skill;
  final ValueChanged<bool> onChanged;

  const SkillChip({Key key, this.skill, this.onChanged}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
        selected: skill.isSelected,
        label: Text(skill.skillName),
        pressElevation: 2,
        labelStyle: TextStyle(color: Colors.black),
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6))),
        onSelected: (bool value) async {
          onChanged(value);
        });
  }
}
