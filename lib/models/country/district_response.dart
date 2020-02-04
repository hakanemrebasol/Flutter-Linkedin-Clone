
import 'district.dart';

class DistrictResponse {
  List<District> _districtList;

  DistrictResponse({List<District> districtList}) {
    this._districtList = districtList;
  }

  List<District> get districtList => _districtList;
  set districtList(List<District> districtList) => _districtList = districtList;

  DistrictResponse.fromJsonArray(List<dynamic> json) {
    var data = json.map((m) => new District.fromJson(m)).toList();
    _districtList = data;
  }
}
