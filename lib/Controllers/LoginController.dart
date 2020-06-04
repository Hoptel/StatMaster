import 'dart:async';
import 'package:scoped_model/scoped_model.dart';

import '../Utilities/Preference.dart';
import '../Utilities/Conveyors/login/LoginConveyor.dart';

///
/// This Class deals with checking User credentials with the service, and returning [_isSuccess] to the page,
/// It also deals with retrieving the [agencyLogo] from the service and passing it to the page,
/// and finally it keeps track of the navigation bar index for the [MainContainerScreen]
/// it is used by [LoginScreen].
///

class LoginController extends Model {
  bool _isSuccess;
  bool _isLoading = false;
  bool _rememberMe = false;
  bool showPassword = false;
  static bool isUserLoggedIn = false;


  String version = "";
  String buildNumber = "";

  bool get isSuccess => _isSuccess;

  bool get isLoading => _isLoading;

  bool get rememberMe => _rememberMe;

  void changeLoginStatus(bool status) {
    isUserLoggedIn = status;
    notifyListeners();
  }

  Future loginRequest(username, password, remember) async {
    _isLoading = true;
    notifyListeners();

    var _loginAuth = await LoginConveyor.getInstance().getLoginAuth(username, password, multiUser: true);

    if (_loginAuth != null && _loginAuth.data != null) {
      _isSuccess = true;
      isUserLoggedIn = true;
      Preference.setBool('remember_me', remember);
      _isLoading = false;

      notifyListeners();
    } else {
      _isSuccess = false;
      _isLoading = false;
      notifyListeners();
    }
  }

  Future changeUser(String code) async {
    await LoginConveyor.getInstance().getRefreshTokenAuth(identifier: code, multiUser: true);
  }

  void remember(bool value) {
    _rememberMe = value ?? false;
    notifyListeners();
  }

  void updateShowPassword({bool value}) {
    showPassword = value ?? !showPassword;
    notifyListeners();
  }
}
