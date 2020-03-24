import 'package:flutter/material.dart';
import 'package:worker_manager/executor.dart';

import 'Utilities/Preference.dart';
import 'View/Screens/LoginScreen.dart';
import 'theme.dart';

void main() async
{ 
    WidgetsFlutterBinding.ensureInitialized();
    runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Executor().warmUp();
    Preference.initialize();
    return MaterialApp(
      title: 'Stat Master',
      theme: theme,
      home: LoginScreen(),
    );
  }
}
