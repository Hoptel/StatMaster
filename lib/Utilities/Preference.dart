import 'dart:async';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:preferences/preferences.dart';

import '../AppConstants.dart';
import '../Utilities/Models/login/LoginAuth.dart';
import '../Utilities/Models/login/UserInfo.dart';

class Preference {
  static FlutterSecureStorage secureStorage;

  static Future initialize() async {
    await PrefService.init(prefix: 'statmaster_');
    secureStorage = secureStorage ?? new FlutterSecureStorage();
  }

  static String getString(String key, {String defaultValue = ""}) {
    return PrefService.getString(key) ?? defaultValue;
  }

  static Future<String> getSecureString(String key, {String defaultValue = ""}) async {
    String secureString = await secureStorage.read(key: key);
    return secureString;
  }

  static bool getBool(String key, {bool defaultValue = false}) {
    return PrefService.getBool(key) ?? defaultValue;
  }

  static Future<bool> getSecureBool(String key, {bool defaultValue = false}) async {
    String secureString = await secureStorage.read(key: key);
    bool secureBool = secureString == 'true';
    return secureBool;
  }

  static int getInt(String key, {int defaultValue = 0}) {
    return PrefService.getInt(key) ?? defaultValue;
  }

  static Future<int> getSecureInt(String key, {int defaultValue = 0}) async {
    String secureString = await secureStorage.read(key: key);
    int secureInt =
        secureString != null && secureString != "null" ? int.parse(secureString ?? defaultValue.toString() ?? "0") : 0;
    return secureInt;
  }

  static double getDouble(String key, {double defaultValue = 0.0}) {
    return PrefService.getDouble(key) ?? defaultValue;
  }

  static Future<double> getSecureDouble(String key, {double defaultValue = 0.0}) async {
    String secureString = await secureStorage.read(key: key);
    double secureDouble = secureString != null && secureString != "null"
        ? double.parse(secureString ?? defaultValue.toString() ?? "0.0")
        : 0.0;
    return secureDouble;
  }

  static Future<Map<String, LoginAuth>> getSecureLoginMap() async {
    String secureString = await secureStorage.read(key: PreferenceKeys.multi_user_login);
    if (secureString != null && secureString != "null") {
      Map<String, dynamic> secureList = jsonDecode(secureString);
      Map<String, LoginAuth> loginList = Map<String, LoginAuth>();
      for (String key in secureList.keys) {
        loginList[key] = LoginAuth.fromJson(secureList[key]);
      }
      return loginList;
    } else
      return null;
  }

  static Future<LoginAuth> getCurrentUser() async {
    String secureString = await secureStorage.read(key: PreferenceKeys.current_user);
    LoginAuth currentUser =
        secureString != null && secureString != 'null' ? LoginAuth.fromJson(jsonDecode(secureString)) : null;
    return currentUser;
  }

  static Future setCurrentUser(LoginAuth loginAuth) async {
    String secureString = json.encode(loginAuth);
    if (loginAuth != null) {
      await secureStorage.write(key: PreferenceKeys.current_user, value: secureString);
    } else {
      await secureStorage.delete(key: PreferenceKeys.current_user);
    }
  }

  static Future setSecureLoginMap(Map<String, LoginAuth> map) async {
    if (map != null) {
      String secureString = json.encode(map);
      await secureStorage.write(key: PreferenceKeys.multi_user_login, value: secureString);
    } else {
      await secureStorage.delete(key: PreferenceKeys.multi_user_login);
    }
  }

  static Future setString(String key, String value) async {
    await PrefService.setString(key, value);
  }

  static Future setSecureString(String key, String value) async {
    if (key != null && value != null) await secureStorage.write(key: key, value: value);
  }

  static Future setBool(String key, bool value) async {
    await PrefService.setBool(key, value);
  }

  static Future setSecureBool(String key, bool value) async {
    await secureStorage.write(key: key, value: value.toString());
  }

  static Future setInt(String key, int value) async {
    await PrefService.setInt(key, value);
  }

  static Future setSecureInt(String key, int value) async {
    await secureStorage.write(key: key, value: value.toString());
  }

  static Future setDouble(String key, double value) async {
    await PrefService.setDouble(key, value);
  }

  static Future setSecureDouble(String key, double value) async {
    await secureStorage.write(key: key, value: value.toString());
  }

  static Future invalidateTokens() async {
    await secureStorage.deleteAll();
  }

  ///used to save token details for a single user
  static Future saveLoginAuth(LoginAuth aLoginAuth) async {
    await setCurrentUser(aLoginAuth);
  }

  ///used to delete token details for a single user
  static Future deleteLoginAuth() async {
    await setCurrentUser(null);
  }

  static Future editLoginAuth(LoginAuth loginAuth, String userIdentifier) async {
    Map<String, LoginAuth> map = await getSecureLoginMap();
    map = map ?? Map<String, LoginAuth>();
    map[userIdentifier] = loginAuth;
    await setSecureLoginMap(map);
  }

  static Future removeLoginAuth(String userIdentifier) async {
    Map<String, LoginAuth> map = await getSecureLoginMap();
    map.remove(userIdentifier);
    await setSecureLoginMap(map);
  }

  static Future removeAllLoginAuth() async {
    await setSecureLoginMap(null);
  }

  static Future setUserInfo(UserInfo userInfo) async {
    await setSecureInt(PreferenceKeys.authlevel, userInfo.authlevel);
    await setSecureString(PreferenceKeys.code, userInfo.code);
    await setSecureInt(PreferenceKeys.hotelrefno, userInfo.hotelrefno);
    await setSecureString(PreferenceKeys.email, userInfo.email);
    await setSecureString(PreferenceKeys.guid, userInfo.guid);
    await setSecureInt(PreferenceKeys.userid, userInfo.userid);
  }

  static Future<LoginAuth> getLoginAuth({String userIdentifier}) async {
    LoginAuth value;
    if (userIdentifier == null) {
      value = await getCurrentUser();
    } else {
      Map<String, LoginAuth> map = await getSecureLoginMap();
      value = map[userIdentifier];
    }
    return value;
  }

  static Future<String> getAccessToken({String userIdentifier}) async {
    LoginAuth value = await getLoginAuth(userIdentifier: userIdentifier);
    return value?.accessToken;
  }

  static Future<String> getRefreshToken({String userIdentifier}) async {
    LoginAuth value = await getLoginAuth(userIdentifier: userIdentifier);
    return value?.refreshToken;
  }

  static Future<int> getExpiresAt({String userIdentifier}) async {
    LoginAuth value = await getLoginAuth(userIdentifier: userIdentifier);
    return value?.expiresIn;
  }

  static Future<int> getUserID() async {
    return await getSecureInt(PreferenceKeys.user_id);
  }

}
