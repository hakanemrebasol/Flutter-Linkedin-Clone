
import 'industry.dart';

class IndustryResponse {
  List<Industry> _industryList;

  IndustryResponse({List<Industry> industryList}) {
    this._industryList = industryList;
  }

  List<Industry> get industryList => _industryList;
  set industryList(List<Industry> industryList) => _industryList = industryList;

  IndustryResponse.fromJsonArray(List<dynamic> json) {
    var data = json.map((m) => new Industry.fromJson(m)).toList();
    _industryList = data;
  }
}
