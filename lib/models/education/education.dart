class Education {
  int _educationId;
  String _educationName;

  Education({int educationId, String educationName}) {
    this._educationId = educationId;
    this._educationName = educationName;
  }

  int get educationId => _educationId;
  set educationId(int educationId) => _educationId = educationId;
  String get educationName => _educationName;
  set educationName(String educationName) => _educationName = educationName;

  Education.fromJson(Map<String, dynamic> json) {
    _educationId = json['educationId'];
    _educationName = json['educationName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['educationId'] = this._educationId;
    data['educationName'] = this._educationName;
    return data;
  }
}

