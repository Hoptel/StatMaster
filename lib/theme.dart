import 'package:flutter/material.dart';

  final ThemeData theme = ThemeData(
    primarySwatch: MaterialColor(4283272113,{50: Color( 0xffedf3f7 )
		, 100: Color( 0xffdbe8f0 )
		, 200: Color( 0xffb8d1e0 )
		, 300: Color( 0xff94bad1 )
		, 400: Color( 0xff71a3c1 )
		, 500: Color( 0xff4d8cb2 )
		, 600: Color( 0xff3e708e )
		, 700: Color( 0xff2e546b )
		, 800: Color( 0xff1f3847 )
		, 900: Color( 0xff0f1c24 )
		}),
    brightness: Brightness.dark,
    primaryColor: Color( 0xff4d8bb1 ),
    primaryColorBrightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      brightness:Brightness.dark,
      color:Color(0xff1c2327),
      elevation:0.0,
      iconTheme:null,
      actionsIconTheme:null,
      textTheme:TextTheme(title: TextStyle(color: Color(0xff4d8bb1), fontSize: 16.0)),),
    primaryColorLight: Color( 0xff7fbbe3 ),
    primaryColorDark: Color( 0xff105e81 ),
    accentColor: Color( 0xff40a4ac ),
    accentColorBrightness: Brightness.dark,
    canvasColor: Color( 0xff1c2327 ),
    scaffoldBackgroundColor: Color( 0xff1c2327 ),
    bottomAppBarColor: Color( 0xff1c2327 ),
    cardColor: Color( 0xff242D32 ),
    dividerColor: Color( 0x1fffffff ),
    highlightColor: Color( 0x40cccccc ),
    splashColor: Color( 0x40cccccc ),
    selectedRowColor: Color( 0xfff5f5f5 ),
    unselectedWidgetColor: Color( 0xb3ffffff ),
    disabledColor: Color( 0x62ffffff ),
    buttonColor: Color( 0xff50b1b0 ),
    toggleableActiveColor: Color( 0xff50b1b0 ),
    secondaryHeaderColor: Color( 0xff616161 ),
    textSelectionColor: Color( 0xff64ffda ),
    cursorColor: Color( 0xff4285f4 ),
    textSelectionHandleColor: Color( 0xff1de9b6 ),
    backgroundColor: Color( 0xff616161 ),
    dialogBackgroundColor: Color( 0xff424242 ),
    indicatorColor: Color( 0xff50b1b0 ),
    hintColor: Color( 0x80ffffff ),
    errorColor: Color( 0xffd32f2f ),


    buttonTheme: ButtonThemeData(
      textTheme: ButtonTextTheme.normal,
      minWidth: 88,
      height: 36,
      padding: EdgeInsets.only(top:0,bottom:0,left:16, right:16),
      shape:     RoundedRectangleBorder(
      side: BorderSide(color: Color( 0xff76d6de ), width: 2, style: BorderStyle.solid, ),
      borderRadius: BorderRadius.all(Radius.circular(20.0)),
    )
 ,
      alignedDropdown: false ,
      buttonColor: Color( 0x00000000 ),
      disabledColor: Color( 0x61ffffff ),
      highlightColor: Color( 0x29ffffff ),
      splashColor: Color( 0x1fffffff ),
      focusColor: Color( 0x1fffffff ),
      hoverColor: Color( 0x0affffff ),
      colorScheme: ColorScheme(
        primary: Color( 0xff1d2021 ),
        primaryVariant: Color( 0xff000000 ),
        secondary: Color( 0xff64ffda ),
        secondaryVariant: Color( 0xff00bfa5 ),
        surface: Color( 0xff424242 ),
        background: Color( 0xff616161 ),
        error: Color( 0xffd32f2f ),
        onPrimary: Color( 0xffffffff ),
        onSecondary: Color( 0xff000000 ),
        onSurface: Color( 0xffffffff ),
        onBackground: Color( 0xffffffff ),
        onError: Color( 0xff000000 ),
        brightness: Brightness.dark,
      ),
    ),


    textTheme: TextTheme(
      display4: TextStyle(
      color: Color( 0xb3ffffff ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
      display3: TextStyle(
      color: Color( 0xb3ffffff ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
      display2: TextStyle(
      color: Color( 0xb3ffffff ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
      display1: TextStyle(
      color: Color( 0xb3ffffff ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
      headline: TextStyle(
      color: Color( 0xffffffff ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
      title: TextStyle(
      color: Color( 0xffffffff ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
      subhead: TextStyle(
      color: Color( 0xffffffff ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
      body2: TextStyle(
      color: Color( 0xffffffff ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
      body1: TextStyle(
      color: Color( 0xffffffff ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
      caption: TextStyle(
      color: Color( 0xb3ffffff ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
      button: TextStyle(
      color: Color( 0xffffffff ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
      subtitle: TextStyle(
      color: Color( 0xffffffff ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
      overline: TextStyle(
      color: Color( 0xffffffff ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    ),
    primaryTextTheme: TextTheme(
      display4: TextStyle(
      color: Color( 0xb3ffffff ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
      display3: TextStyle(
      color: Color( 0xb3ffffff ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
      display2: TextStyle(
      color: Color( 0xb3ffffff ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
      display1: TextStyle(
      color: Color( 0xb3ffffff ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
      headline: TextStyle(
      color: Color( 0xffffffff ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
      title: TextStyle(
      color: Color( 0xffffffff ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
      subhead: TextStyle(
      color: Color( 0xffffffff ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
      body2: TextStyle(
      color: Color( 0xffffffff ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
      body1: TextStyle(
      color: Color( 0xffffffff ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
      caption: TextStyle(
      color: Color( 0xb3ffffff ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
      button: TextStyle(
      color: Color( 0xffffffff ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
      subtitle: TextStyle(
      color: Color( 0xffffffff ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
      overline: TextStyle(
      color: Color( 0xffffffff ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    ),
    accentTextTheme: TextTheme(
      display4: TextStyle(
      color: Color( 0x8a000000 ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
      display3: TextStyle(
      color: Color( 0x8a000000 ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
      display2: TextStyle(
      color: Color( 0x8a000000 ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
      display1: TextStyle(
      color: Color( 0x8a000000 ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
      headline: TextStyle(
      color: Color( 0xdd000000 ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
      title: TextStyle(
      color: Color( 0xdd000000 ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
      subhead: TextStyle(
      color: Color( 0xdd000000 ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
      body2: TextStyle(
      color: Color( 0xdd000000 ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
      body1: TextStyle(
      color: Color( 0xdd000000 ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
      caption: TextStyle(
      color: Color( 0x8a000000 ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
      button: TextStyle(
      color: Color( 0xdd000000 ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
      subtitle: TextStyle(
      color: Color( 0xff000000 ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
      overline: TextStyle(
      color: Color( 0xff000000 ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    ),
    inputDecorationTheme:   InputDecorationTheme(
    labelStyle: TextStyle(
      color: Color( 0xffffffff ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    helperStyle: TextStyle(
      color: Color( 0xffffffff ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    hintStyle: TextStyle(
      color: Color( 0xffffffff ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    errorStyle: TextStyle(
      color: Color( 0xffffffff ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    errorMaxLines: null,
    hasFloatingPlaceholder: true,
    isDense: false,
    contentPadding: EdgeInsets.only(top:12,bottom:12,left:0, right:0),
    isCollapsed : false,
    prefixStyle: TextStyle(
      color: Color( 0xffffffff ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    suffixStyle: TextStyle(
      color: Color( 0xffffffff ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    counterStyle: TextStyle(
      color: Color( 0xffffffff ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    filled: false,
    fillColor: Color( 0x00000000 ),
    errorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color( 0xff000000 ), width: 1, style: BorderStyle.solid, ),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color( 0xff000000 ), width: 1, style: BorderStyle.solid, ),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    focusedErrorBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color( 0xff000000 ), width: 1, style: BorderStyle.solid, ),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    disabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color( 0xff000000 ), width: 1, style: BorderStyle.solid, ),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Color( 0xff000000 ), width: 1, style: BorderStyle.solid, ),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
    border: UnderlineInputBorder(
      borderSide: BorderSide(color: Color( 0xff000000 ), width: 1, style: BorderStyle.solid, ),
      borderRadius: BorderRadius.all(Radius.circular(4.0)),
    ),
  ),
    iconTheme: IconThemeData(
      color: Color( 0xffffffff ),
      opacity: 1,
      size: 24,
    ),
    primaryIconTheme: IconThemeData(
      color: Color( 0xffffffff ),
      opacity: 1,
      size: 24,
    ),
    accentIconTheme: IconThemeData(
      color: Color( 0xff000000 ),
      opacity: 1,
      size: 24,
    ),
    /*sliderTheme: SliderThemeData(
      activeTrackColor: null,
      inactiveTrackColor: null,
      disabledActiveTrackColor: null,
      disabledInactiveTrackColor: null,
      activeTickMarkColor: null,
      inactiveTickMarkColor: null,
      disabledActiveTickMarkColor: null,
      disabledInactiveTickMarkColor: null,
      thumbColor: Color( 0xff50b1b0 ),
      disabledThumbColor: Color( 0xff545454 ),
      thumbShape: null,
      overlayColor: null,
      valueIndicatorColor: null,
      valueIndicatorShape: null(),
      showValueIndicator: ShowValueIndicator.always,
      valueIndicatorTextStyle: TextStyle(
      color: Color( 0xdd000000 ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
    ),*/
    tabBarTheme: TabBarTheme(
      indicatorSize: TabBarIndicatorSize.tab,
      labelColor: Color( 0xff50b1b0 ),
      unselectedLabelColor: Color( 0xffffffff ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: Color( 0xff50b1b0 ),
      brightness: Brightness.dark,
      deleteIconColor: Color( 0xdeffffff ),
      disabledColor: Color( 0xff545455 ),
      labelPadding: EdgeInsets.only(top:0,bottom:0,left:8, right:8),
      labelStyle: TextStyle(
      color: Color( 0xdeffffff ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
      padding: EdgeInsets.only(top:4,bottom:4,left:4, right:4),
      secondaryLabelStyle: TextStyle(
      color: Color( 0xff50b1b0 ),
      fontSize: null,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
    ),
      secondarySelectedColor: Color( 0xff50b1b0 ),
      selectedColor: Color( 0xff50b1b0 ),
      shape: StadiumBorder( side: BorderSide(color: Color( 0xff000000 ), width: 0, style: BorderStyle.none, ) ),
    ),
    dialogTheme: DialogTheme(
      shape:     RoundedRectangleBorder(
      side: BorderSide(color: Color( 0xff000000 ), width: 0, style: BorderStyle.none, ),
      borderRadius: BorderRadius.all(Radius.circular(0.0)),
    )

    ),
  );

  class AppColors
  {
    static const Color primary = const Color(0xff4d8bb1);
    static const Color primaryDark = const Color(0xff105e81);
    static const Color primaryLight = const Color(0xff7fbbe3);
    static const Color secondary = const Color(0xff40a4ac);
    static const Color secondaryDark = const Color(0xff00757d);
    static const Color secondaryLight = const Color(0xff76d6de);
  }
