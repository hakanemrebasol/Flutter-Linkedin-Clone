import 'education.dart';

class EducationResponse {
  List<Education> _educationList;

  EducationResponse({List<Education> educationList}) {
    this._educationList = educationList;
  }

  List<Education> get educationList => _educationList;
  set educationList(List<Education> educationList) =>
      _educationList = educationList;

  EducationResponse.fromJsonArray(List<dynamic> json) {
    var data = json.map((m) => new Education.fromJson(m)).toList();
    _educationList = data;
  }
}
