import 'package:flutter/material.dart';

import 'Utilities/Preference.dart';
import 'View/Screens/LoginScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Preference.initialize();
    return MaterialApp(
      title: 'Stat Master',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primaryColor: Color(0xff40A477),
        canvasColor: Color(0xff1D2021),
        buttonColor: Color(0xff50b2B0),
        appBarTheme: AppBarTheme(brightness: Brightness.dark, color: Color(0xff242828), elevation: 1.0),
        brightness: Brightness.dark,
      ),
      home: LoginScreen(),
    );
  }
}
