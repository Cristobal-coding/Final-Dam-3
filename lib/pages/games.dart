import 'package:final_dam_3/constants.dart';
import 'package:final_dam_3/services/firestore.dart';
import 'package:flutter/material.dart';

class JuegosPage extends StatefulWidget {
  JuegosPage({Key key}) : super(key: key);

  @override
  _JuegosPageState createState() => _JuegosPageState();
}

class _JuegosPageState extends State<JuegosPage> {
  FireStoreService juegos = FireStoreService();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Juegos Disponibles',
              style: TextStyle(
                  fontFamily: titulosFontFamily,
                  fontSize: 25,
                  color: kSecondaryColor),
            ),
          ),
          StreamBuilder(
            stream: FireStoreService().juegos(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              return Text('data');
            },
          ),
        ],
      ),
    );
  }
}
