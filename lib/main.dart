import 'package:final_dam_3/pages/base_page.dart';
import 'package:final_dam_3/pages/login_page.dart';
import 'package:final_dam_3/pages/navegador.dart';
import 'package:final_dam_3/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return StreamProvider<User>.value(
            initialData: null,
            value: AuthService().usuario,
            child: MaterialApp(
              title: 'Videogames App',
              theme: ThemeData(
                  primaryColor: kPrimaryColor,
                  fontFamily: normalFontFamily,
                  scaffoldBackgroundColor: kBackgroundColor),
              home: MainNav(),
              // home: BasePage(),
            ),
          );
        });
  }
}
