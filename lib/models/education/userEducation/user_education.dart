import 'package:taskproject/util/date_extension.dart';

import '../education.dart';

class UserEducation {
  int _userEducationId;
  DateTime _startDate;
  DateTime _endDate;
  String _description;
  int _educationId;
  Education _education;

  UserEducation(
      {int userEducationId,
      DateTime startDate,
      DateTime endDate,
      String description,
      int educationId,
      Education education}) {
    this._userEducationId = userEducationId;
    this._startDate = startDate;
    this._endDate = endDate;
    this._description = description;
    this._educationId = educationId;
    this._education = education;
  }

  int get userEducationId => _userEducationId;
  set userEducationId(int userEducationId) =>
      _userEducationId = userEducationId;
  DateTime get startDate => _startDate;
  set startDate(DateTime startDate) => _startDate = startDate;
  DateTime get endDate => _endDate;
  set endDate(DateTime endDate) => _endDate = endDate;
  String get description => _description;
  set description(String description) => _description = description;
  int get educationId => _educationId;
  set educationId(int educationId) => _educationId = educationId;
  Education get education => _education;
  set education(Education education) => _education = education;

  UserEducation.fromJson(Map<String, dynamic> json) {
    _userEducationId = json['userEducationId'];
    _startDate = convertStrToDatetime(json['startDate']);
    _endDate = convertStrToDatetime(json['endDate']);
    _description = json['description'];
    _educationId = json['educationId'];
    _education = json['education'] != null
        ? new Education.fromJson(json['education'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._userEducationId != null) {
      data['userEducationId'] = this._userEducationId;
    }
    data['startDate'] = this._startDate.toIso8601String();
    data['endDate'] = this._endDate.toIso8601String();
    data['description'] = this._description;
    data['educationId'] = this._education.educationId;
    /*if (this._education != null) {
      data['education'] = this._education.toJson();
    }*/
    return data;
  }
}

