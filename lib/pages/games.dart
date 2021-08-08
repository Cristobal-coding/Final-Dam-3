import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
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
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8.0),
            height: 450,
            child: StreamBuilder(
              stream: FireStoreService().juegos(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                var juegos = snapshot.data.docs;
                return ListView.separated(
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (_, __) => Divider(),
                  itemCount: juegos.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(5.0),
                      width: 250,
                      height: double.infinity,
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.network(
                              juegos[index]['img'],
                              // height: 400,
                              // width: 300,
                            ),
                          ),
                          Text(juegos[index]['nombre'])
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
