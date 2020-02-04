import 'package:taskproject/models/company/company.dart';
import 'package:taskproject/util/date_extension.dart';

class Experience {
  int _experienceId;
  String _title;
  String _location;
  DateTime _startDate;
  DateTime _endDate;
  String _description;
  int _companyId;
  Company _company;

  Experience(
      {int experienceId,
      String title,
      String location,
      DateTime startDate,
      DateTime endDate,
      String description,
      int companyId,
      Company company}) {
    this._experienceId = experienceId;
    this._title = title;
    this._location = location;
    this._startDate = startDate;
    this._endDate = endDate;
    this._description = description;
    this._companyId = companyId;
    this._company = company;
  }

  int get experienceId => _experienceId;
  set experienceId(int experienceId) => _experienceId = experienceId;
  String get title => _title;
  set title(String title) => _title = title;
  String get location => _location;
  set location(String location) => _location = location;
  DateTime get startDate => _startDate;
  set startDate(DateTime startDate) => _startDate = startDate;
  DateTime get endDate => _endDate;
  set endDate(DateTime endDate) => _endDate = endDate;
  String get description => _description;
  set description(String description) => _description = description;
  int get companyId => _companyId;
  set companyId(int companyId) => _companyId = companyId;
  Company get company => _company;
  set company(Company company) => _company = company;

  Experience.fromJson(Map<String, dynamic> json) {
    _experienceId = json['experienceId'];
    _title = json['title'];
    _location = json['location'];
    _startDate = convertStrToDatetime(json['startDate']);
    _endDate = convertStrToDatetime(json['endDate']);
    _description = json['description'];
    _companyId = json['companyId'];
    _company =
        json['company'] != null ? new Company.fromJson(json['company']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._experienceId != null) {
      data['experienceId'] = this._experienceId;
    }
    data['title'] = this._title;
    data['location'] = this._location;
    data['startDate'] = this._startDate.toIso8601String();
    data['endDate'] = this._endDate.toIso8601String();
    data['description'] = this._description;
    data['companyId'] = this._company.companyId;
    return data;
  }
}
