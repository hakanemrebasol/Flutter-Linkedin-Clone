
import 'experience.dart';

class ExperienceResponse {
  List<Experience> _experienceList;

  ExperienceResponse({List<Experience> experienceList}) {
    this._experienceList = experienceList;
  }

  List<Experience> get experienceList => _experienceList;
  set experienceList(List<Experience> companyList) =>
      _experienceList = experienceList;

  ExperienceResponse.fromJsonArray(List<dynamic> json) {
    var data = json.map((m) => new Experience.fromJson(m)).toList();
    _experienceList = data;
  }
}
