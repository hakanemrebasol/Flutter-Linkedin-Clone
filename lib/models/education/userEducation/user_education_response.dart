import 'package:taskproject/models/education/userEducation/user_education.dart';

class UserEducationResponse {
  List<UserEducation> _userEducationList;

  UserEducationResponse({List<UserEducation> userEducationList}) {
    this._userEducationList = userEducationList;
  }

  List<UserEducation> get userEducationList => _userEducationList;
  set userEducationList(List<UserEducation> userEducationList) =>
      _userEducationList = userEducationList;

  UserEducationResponse.fromJsonArray(List<dynamic> json) {
    var data = json.map((m) => new UserEducation.fromJson(m)).toList();
    _userEducationList = data;
  }
}
