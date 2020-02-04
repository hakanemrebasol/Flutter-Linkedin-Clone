class Industry {
  int _industryId;
  String _industryName;

  Industry({int industryId, String industryName}) {
    this._industryId = industryId;
    this._industryName = industryName;
  }

  int get industryId => _industryId;
  set industryId(int industryId) => _industryId = industryId;
  String get industryName => _industryName;
  set industryName(String industryName) => _industryName = industryName;

  Industry.fromJson(Map<String, dynamic> json) {
    _industryId = json['industryId'];
    _industryName = json['industryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['industryId'] = this._industryId;
    data['industryName'] = this._industryName;
    return data;
  }
}
