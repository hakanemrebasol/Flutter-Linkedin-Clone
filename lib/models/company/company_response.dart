import 'company.dart';

class CompanyResponse {
  List<Company> _companyList;

  CompanyResponse({List<Company> companyList}) {
    this._companyList = companyList;
  }

  List<Company> get companyList => _companyList;
  set companyList(List<Company> companyList) => _companyList = companyList;

  CompanyResponse.fromJsonArray(List<dynamic> json) {
    var data = json.map((m) => new Company.fromJson(m)).toList();
    _companyList = data;
  }
}
