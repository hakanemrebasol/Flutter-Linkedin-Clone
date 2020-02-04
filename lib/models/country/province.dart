class Province {
  int _provinceId;
  String _provinceName;

  Province({int provinceId, String provinceName}) {
    this._provinceId = provinceId;
    this._provinceName = provinceName;
  }

  int get provinceId => _provinceId;
  set provinceId(int provinceId) => _provinceId = provinceId;
  String get provinceName => _provinceName;
  set provinceName(String provinceName) => _provinceName = provinceName;

  Province.fromJson(Map<String, dynamic> json) {
    _provinceId = json['provinceId'];
    _provinceName = json['provinceName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['provinceId'] = this._provinceId;
    data['provinceName'] = this._provinceName;
    return data;
  }
}

