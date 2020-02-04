class AuthenticationResponse {
  String _userId;
  String _accessToken;
  String _refreshToken;

  AuthenticationResponse(
      {String userId, String accessToken, String refreshToken}) {
    this._userId = userId;
    this._accessToken = accessToken;
    this._refreshToken = refreshToken;
  }

  String get userId => _userId;
  set userId(String userId) => _userId = userId;
  String get accessToken => _accessToken;
  set accessToken(String accessToken) => _accessToken = accessToken;
  String get refreshToken => _refreshToken;
  set refreshToken(String refreshToken) => _refreshToken = refreshToken;

  AuthenticationResponse.fromJson(Map<String, dynamic> json) {
    _userId = json['userId'];
    _accessToken = json['accessToken'];
    _refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = this._userId;
    data['accessToken'] = this._accessToken;
    data['refreshToken'] = this._refreshToken;
    return data;
  }
}
