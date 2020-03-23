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

  static double getExtraBottomHeight(BuildContext context) {
    return MediaQuery.of(context).padding.bottom;
  }

  static double screenRealEstate(BuildContext context,
      {bool hasAppBar = true, bool hasNavBar = false, bool includeBottomPadding = true}) {
    return screenHeight(context) - statusBarHeight(context) - (includeBottomPadding ? getExtraBottomHeight(context) : 0.0) -
        (hasNavBar ? appbarHeight : 0.0) - (hasAppBar ? appbarHeight : 0.0);
  }

  static const bool isDEBUG = !bool.fromEnvironment("dart.vm.product");
}