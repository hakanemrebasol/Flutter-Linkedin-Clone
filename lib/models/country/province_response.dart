import 'package:taskproject/models/country/province.dart';

class ProvinceResponse {
  List<Province> _provinceList;

  ProvinceResponse({List<Province> provinceList}) {
    this._provinceList = provinceList;
  }

  List<Province> get provinceList => _provinceList;
  set provinceList(List<Province> provinceList) => _provinceList = provinceList;

  ProvinceResponse.fromJsonArray(List<dynamic> json) {
    var data = json.map((m) => new Province.fromJson(m)).toList();
    _provinceList = data;
  }
}
