import 'package:flutter/material.dart';

class JuegosPage extends StatefulWidget {
  JuegosPage({Key key}) : super(key: key);

  @override
  _JuegosPageState createState() => _JuegosPageState();
}

class _JuegosPageState extends State<JuegosPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text('Juegos page')),
    );
  }
}
