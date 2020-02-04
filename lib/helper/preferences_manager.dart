import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskproject/models/authentication/authentication_response.dart';

class PreferencesManager {
  String keyRememberMe = 'remember_me';
  String keyAccessToken = 'access_token';
  String keyRefreshToken = 'refresh_token';
  String keyUserId = 'user_id';

  Future<bool> saveLoginDetails(
      AuthenticationResponse authenticationResponse, bool rememberMe) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keyRememberMe, rememberMe);
    await prefs.setString(keyAccessToken, authenticationResponse.accessToken);
    await prefs.setString(keyRefreshToken, authenticationResponse.refreshToken);
    return await prefs.setString(keyUserId, authenticationResponse.userId);
  }

  Future<AuthenticationResponse> getLoginDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return new AuthenticationResponse(
        accessToken: prefs.getString(keyAccessToken),
        refreshToken: prefs.getString(keyRefreshToken),
        userId: prefs.getString(keyUserId));
  }

  Future<String> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(keyAccessToken);
    return 'Bearer $token';
  }

  Future<String> getAccessTokenOnly() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(keyAccessToken);
    return token;
  }

  Future<String> getRefreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(keyRefreshToken);
    return token;
  }

  Future<String> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyUserId);
  }

  Future<void> resetLoginDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(keyAccessToken);
    prefs.remove(keyRefreshToken);
    prefs.remove(keyRememberMe);
    prefs.remove(keyUserId);
  }
}
