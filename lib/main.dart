import 'package:final_dam_3/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Videogames App',
      theme: ThemeData(
          primaryColor: kPrimaryColor,
          fontFamily: normalFontFamily,
          scaffoldBackgroundColor: kBackgroundColor),
      home: LoginPage(),
    );
  }
}
