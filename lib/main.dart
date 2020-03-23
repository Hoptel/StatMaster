import 'package:flutter/material.dart';

import 'Utilities/Preference.dart';
import 'View/Screens/LoginScreen.dart';
import 'theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Preference.initialize();
    return MaterialApp(
      title: 'Stat Master',
      theme: theme,
      home: LoginScreen(),
    );
  }
}
