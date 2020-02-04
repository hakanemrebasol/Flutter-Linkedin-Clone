import 'package:taskproject/models/country/district.dart';
import 'package:taskproject/models/country/province.dart';

class ProfileSummary {
  String _id;
  String _fullName;
  String _headline;
  String _about;
  String _website;
  Province _province;
  District _district;

  ProfileSummary(
      {String id,
      String fullName,
      String headline,
      String about,
      String website,
      Province province,
      District district}) {
    this._id = id;
    this._fullName = fullName;
    this._headline = headline;
    this._about = about;
    this._website = website;
    this._province = province;
    this._district = district;
  }

  String get id => _id;
  set id(String id) => _id = id;
  String get fullName => _fullName;
  set fullName(String fullName) => _fullName = fullName;
  String get headline => _headline;
  set headline(String headline) => _headline = headline;
  String get about => _about;
  set about(String about) => _about = about;
  String get website => _website;
  set website(String website) => _website = website;
  Province get province => _province;
  set province(Province province) => _province = province;
  District get district => _district;
  set district(District district) => _district = district;

  ProfileSummary.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _fullName = json['fullName'];
    _headline = json['headline'];
    _about = json['about'];
    _website = json['website'];
    _province = json['province'] != null
        ? new Province.fromJson(json['province'])
        : null;
    _district = json['district'] != null
        ? new District.fromJson(json['district'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['fullName'] = this._fullName;
    data['headline'] = this._headline;
    data['about'] = this._about;
    data['website'] = this._website;
    if (this._province != null) {
      data['province'] = this._province.toJson();
    }
    if (this._district != null) {
      data['district'] = this._district.toJson();
    }
    return data;
  }
}
