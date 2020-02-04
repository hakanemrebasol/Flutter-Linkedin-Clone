import 'package:taskproject/models/skill/skill.dart';

class SkillResponse {
  List<Skill> _skillList;

  SkillResponse({List<Skill> skillList}) {
    this._skillList = skillList;
  }

  List<Skill> get skillList => _skillList;
  set skillList(List<Skill> companyList) =>
      _skillList = skillList;

  SkillResponse.fromJsonArray(List<dynamic> json) {
    var data = json.map((m) => new Skill.fromJson(m)).toList();
    _skillList = data;
  }
}
