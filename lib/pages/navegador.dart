import 'package:flutter/material.dart';

class MainNav extends StatefulWidget {
  MainNav({Key key}) : super(key: key);

  @override
  _MainNavState createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Probando'),
      ),
    );
  }
}
