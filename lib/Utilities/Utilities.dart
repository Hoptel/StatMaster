import 'package:flutter/material.dart';

const String imagePath = "/resources/image_assets/";

class Utils {
  static const double appbarHeight = 56.0;

  static Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static double screenHeight(BuildContext context) {
    return screenSize(context).height;
  }

  static double screenWidth(BuildContext context) {
    return screenSize(context).width;
  }

  static double statusBarHeight(BuildContext context) {
    return MediaQuery.of(context).padding.top;
  }

  ///
  /// IphoneX and later notched Iphones have a "Home Bar" at the bottom, this causes extra padding to be present
  /// at the bottom than normal, this method returns that extra padding.
  ///
  static double getBottomNavBarExtraHeight(BuildContext context) {
    return MediaQuery.of(context).padding.bottom;
  }

  ///
  /// height of screen excluding statusBar, Bottom Navigation Bar, toolbar(Appbar) height, and any extra padding caused
  /// by the notched Iphones' bottom home bar.
  ///
  static double screenRealEstate(BuildContext context,
      {bool hasAppBar = true, bool hasNavBar = false, bool includeBottomPadding = true}) {
    return screenHeight(context) -
        statusBarHeight(context) -
        (includeBottomPadding ? getBottomNavBarExtraHeight(context) : 0.0) -
        (hasNavBar ? appbarHeight : 0.0) -
        (hasAppBar ? appbarHeight : 0.0);
  }

  static const bool isDEBUG = !bool.fromEnvironment("dart.vm.product");

  ///
  ///Splits the printed objects into smaller lines that are slightly more readeable and don't crash your IDE
  ///
  static void logPrint(Object object) async {
    const int defaultPrintLength = 1024;
    String log = object.toString();
    int counter = log.length - defaultPrintLength;
    while (counter > 0){
      log = log.replaceRange(counter, counter, '\n');
    } 
    print (log);
  }
}
