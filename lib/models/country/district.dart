import 'package:taskproject/models/country/province.dart';

class District {
  int _districtId;
  String _districtName;
  int _provinceId;
  Province _province;

  District(
      {int districtId,
      String districtName,
      int provinceId,
      Province province}) {
    this._districtId = districtId;
    this._districtName = districtName;
    this._provinceId = provinceId;
    this._province = province;
  }

  int get districtId => _districtId;
  set districtId(int districtId) => _districtId = districtId;
  String get districtName => _districtName;
  set districtName(String districtName) => _districtName = districtName;
  int get provinceId => _provinceId;
  set provinceId(int provinceId) => _provinceId = provinceId;
  Province get province => _province;
  set province(Province province) => _province = province;

  District.fromJson(Map<String, dynamic> json) {
    _districtId = json['districtId'];
    _districtName = json['districtName'];
    _provinceId = json['provinceId'];
    _province = json['province'] != null
        ? new Province.fromJson(json['province'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['districtId'] = this._districtId;
    data['districtName'] = this._districtName;
    data['provinceId'] = this._provinceId;
    if (this._province != null) {
      data['province'] = this._province.toJson();
    }
    return data;
  }
}