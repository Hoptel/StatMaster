import 'package:StatMaster/Controllers/LoginController.dart';
import 'package:StatMaster/Controllers/MainController.dart';
import 'package:StatMaster/Utilities/Preference.dart';
import 'package:StatMaster/View/Screens/LoginScreen.dart';
import 'package:StatMaster/View/Screens/WidgetsScreen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static const int waitingTimeMillis = 0;
  checkRememberMe(BuildContext context, MainController mainController, int startTime) async {
    Preference.initialize();
    LoginController loginController = mainController.loginController;
    if (await Preference.getCurrentUser() != null) {
      await loginController.checkAuth();
    }
    int endTime = DateTime.now().toUtc().millisecondsSinceEpoch;
    int differenceTime = endTime - startTime;

    if (differenceTime > waitingTimeMillis) {
      navigateToMain(context);
    } else {
      Future.delayed(Duration(milliseconds: waitingTimeMillis - differenceTime), () {
        navigateToMain(context);
      });
    }
  }

  Future navigateToMain(BuildContext context) {
    MainController.getInstance().resetControllers();
    return Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => 
      LoginController.isUserLoggedIn == true ? WidgetsScreen() : LoginScreen()),
      (Route<dynamic> route) => false,
    );
  }

  //TODO display a loading indicator once the timer passes the waiting time
  @override
  Widget build(BuildContext context) {
    int startTime = DateTime.now().toUtc().millisecondsSinceEpoch;
    MainController mainController = MainController.getInstance();
    mainController.setLoginController(LoginController());
    checkRememberMe(context, mainController, startTime);
    return Scaffold();
  }
}
