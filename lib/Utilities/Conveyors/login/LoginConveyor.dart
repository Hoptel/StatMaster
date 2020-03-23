import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';

import '../../Models/login/LoginAuth.dart';
import '../../Models/login/UserInfo.dart';
import '../../Models/ResponseBody.dart';
import '../../Preference.dart';
import '../RequestHelper.dart';
import '../Conveyor.dart';

class LoginConveyor extends Conveyor {
  static LoginConveyor instance;

  static LoginConveyor getInstance() {
    return instance != null ? instance : LoginConveyor();
  }

  Future<LoginAuth> _login(String username, String password) async {
    String _username = username;
    Response responseAuth = await sendRequest(HttpMethod.POST, '/auth/login', null,
        requestBody: json.encode({
          'grant_type': 'password',
          'username': _username,
          'password': password,
        }),);

    if (responseAuth != null && responseAuth.statusCode == 200) {
      return LoginAuth.fromJson(jsonDecode(responseAuth.body));
    }
    return null;
  }

  @override
  getBlueprintName() => null;

  //if single user: go directly to current user and save stuff there, if no remember me, delete on next launch
  //if multi user: add new user to login map and current user, do not delete
  Future<ResponseBody> getLoginAuth(String username, String password,
      {multiUser = false}) async {
    var responseAuth = await _login(username, password);
    if (responseAuth != null) {
      ResponseBody userInfoResult =
          await fetchUserInfo(headers: {'Authorization': "Bearer ${responseAuth.accessToken}"});
      UserInfo userInfo = UserInfo.fromJson(userInfoResult.data);
      if (multiUser) {
        Preference.editLoginAuth(responseAuth, userInfo.code);
        Preference.setCurrentUser(responseAuth);
        print(await Preference.getSecureLoginMap());
      } else {
        Preference.setCurrentUser(responseAuth);
      }
      return userInfoResult;
    }
    return null;
  }

  //if single user: checks are done when remember me is true (and when you get 401) and are done for current user
  //if multi user: an identifier will be sent and the identifier will be used to pick from login map, otherwise, current user applies, and you update the list
  Future<ResponseBody> getRefreshTokenAuth(
      {String refreshToken, String identifier, multiUser = false}) async {
    Preference.initialize();
    if (refreshToken == null) {
      refreshToken = await Preference.getRefreshToken(userIdentifier: identifier);
    }
    Response responseAuth = await sendRequest(
      HttpMethod.POST,
      '/auth/login',
      null,
      requestBody: {
        'grant_type': 'refresh_token',
        'refresh_token': refreshToken,
      },
    );

    if (responseAuth != null && responseAuth.statusCode == 200) {
      LoginAuth loginAuth = LoginAuth.fromJson(json.decode(responseAuth.body));
      await Preference.setCurrentUser(loginAuth);
      ResponseBody userInfoResult = await fetchUserInfo();
      UserInfo loginfo = UserInfo.fromJson(userInfoResult.data);
      if (multiUser) {
        await Preference.editLoginAuth(loginAuth, identifier ?? loginfo.code);
      }
      return userInfoResult;
    }
    return null;
  }

  Future<int> checkAuthCode() async {
    Response responseUserInfo = await sendRequest(
      HttpMethod.GET,
      "/user/info",
      await RequestHelper.getAuthHeader(),
    );
    return responseUserInfo.statusCode;
  }

  Future<ResponseBody> fetchUserInfo({Map<String, String> headers}) async {
    Response responseUserInfo = await sendRequest(
      HttpMethod.GET,
      "/user/info",
      headers ?? await RequestHelper.getAuthHeader(),
    );

    if (responseUserInfo != null && responseUserInfo.statusCode == 200) {
      var resp = ResponseBody.fromJson(json.decode(responseUserInfo.body));
      await Preference.setUserInfo(UserInfo.fromJson(resp.data));
      return resp;
    } else {
      return null;
    }
  }

  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
