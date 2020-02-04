class LoginModel {
  String _username;
  String _password;

  LoginModel({String username, String password}) {
    this._username = username;
    this._password = password;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this._username;
    data['password'] = this._password;
    return data;
  }
}