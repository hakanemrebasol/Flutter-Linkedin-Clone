class Company {
  int _companyId;
  String _companyName;

  Company({int companyId, String companyName}) {
    this._companyId = companyId;
    this._companyName = companyName;
  }

  int get companyId => _companyId;
  set companyId(int companyId) => _companyId = companyId;
  String get companyName => _companyName;
  set companyName(String companyName) => _companyName = companyName;

  Company.fromJson(Map<String, dynamic> json) {
    _companyId = json['companyId'];
    _companyName = json['companyName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['companyId'] = this._companyId;
    data['companyName'] = this._companyName;
    return data;
  }
}
