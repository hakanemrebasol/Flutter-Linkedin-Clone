class Skill {
  int _skillId;
  String _skillName;
  bool _isSelected;

  Skill({int skillId, String skillName, bool isSelected}) {
    this._skillId = skillId;
    this._skillName = skillName;
    this._isSelected = isSelected;
  }

  int get skillId => _skillId;
  set skillId(int skillId) => _skillId = skillId;
  String get skillName => _skillName;
  set skillName(String skillName) => _skillName = skillName;
  bool get isSelected => _isSelected;
  set isSelected(bool isSelected) => _isSelected = isSelected;

  Skill.fromJson(Map<String, dynamic> json) {
    _skillId = json['skillId'];
    _skillName = json['skillName'];
    _isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['skillId'] = this._skillId;
    data['skillName'] = this._skillName;
    data['isSelected'] = this._isSelected;
    return data;
  }
}