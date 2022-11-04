// ignore: file_names
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  final String token = "token";
  final String email = "email";
  final String password = "password";
  final String userId = "userId";
  final String signinStatus = "signedIn";
  final String socialName = 'socialName';
  final String cognitoId = "cognitoId";
  final String internetStatus = 'internetstatus';

  Future<bool> setToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(token, value);
  }

  Future<bool> setUserId(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userId, value);
  }

  Future<bool> setEmail(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(email, value);
  }

  Future<bool> setPassword(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(password, value);
  }

  Future<bool> setSigninStatus(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(signinStatus, value);
  }

  Future<bool> setSocialLoginName(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(socialName, value);
  }

  Future<bool> setCognitoId(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(cognitoId, value);
  }

  Future<bool> setinternetStatus(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(internetStatus, value);
  }

  Future<String?> getinternetstatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(internetStatus) == null) return '';
    return prefs.getString(internetStatus);
  }

  Future<String?> getCognitoId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(cognitoId) == null) return '';
    return prefs.getString(cognitoId);
  }

  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(token) == null) return '';
    return prefs.getString(token);
  }

  Future<String?> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(userId) == null) return '';
    return prefs.getString(userId);
  }

  Future<String?> getemail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(email) == null) return '';
    return prefs.getString(email);
  }

  Future<String?> getPassword() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(password) == null) return '';
    return prefs.getString(password);
  }

  Future<String?> getSignedin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(signinStatus) == null) return '';
    return prefs.getString(signinStatus);
  }

  Future<String?> getsocialloginName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(socialName) == null) return '';
    return prefs.getString(socialName);
  }
}
