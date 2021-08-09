import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_dam_3/constants.dart';
import 'package:final_dam_3/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:like_button/like_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JuegosPage extends StatefulWidget {
  JuegosPage({Key key}) : super(key: key);

  @override
  _JuegosPageState createState() => _JuegosPageState();
}

class _JuegosPageState extends State<JuegosPage> {
  FireStoreService juegos = FireStoreService();
  var formato =
      NumberFormat.currency(decimalDigits: 0, locale: 'es-CL', symbol: '');

  String uid = '';

  @override
  void initState() {
    this.cargarDatosUsuario();
    super.initState();
  }

  Future cargarDatosUsuario() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      uid = sp.getStringList('user')[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
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
            height: 500,
            child: StreamBuilder(
              stream: FireStoreService().juegos(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                var juegos = snapshot.data.docs;
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: juegos.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(3.0),
                      width: 240,
                      height: double.infinity,
                      // color: Colors.red,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image.network(
                                  juegos[index]['img'],
                                  height: 330,
                                  // width: double.infinity,
                                ),
                              ),
                              Positioned(
                                bottom: 10,
                                left: 7,
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: kPrimaryColor,
                                      borderRadius: BorderRadius.circular(8.0)),
                                  width: 100,
                                  height: 20,
                                  child: Text(
                                    juegos[index]['desarrollador'],
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Container(
                            width: 250,
                            height: 100,
                            padding: EdgeInsets.all(10.0),
                            // color: Colors.red,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  juegos[index]['nombre'],
                                  style: TextStyle(
                                      fontSize: 20,
                                      // fontWeight: FontWeight.bold,
                                      fontFamily: titulosFontFamily),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Plataforma: ',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '${juegos[index]['plataforma']}',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: kSecondaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    StreamBuilder(
                                      stream: FireStoreService()
                                          .checkIsWish(juegos[index].id, uid),
                                      builder: (context, snapshot) {
                                        var deseos = snapshot.data.docs;
                                        if (!snapshot.hasData) {
                                          return Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }
                                        return LikeButton(
                                          isLiked:
                                              deseos.length == 0 ? false : true,
                                          onTap: (value) async {
                                            if (value == false) {
                                              FireStoreService()
                                                  .toListWish(juegos[index].id);
                                            }
                                            if (value == true) {
                                              FireStoreService()
                                                  .removeItemWish(deseos[0].id);
                                            }
                                            return !value;
                                          },
                                          // onTap: onLikeButtonTapped,
                                        );
                                      },
                                    ),
                                    Spacer(),
                                    Text(
                                      '\$${formato.format(juegos[index]['precio'])}',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: manuscritoFontFamily,
                                          fontWeight: FontWeight.bold,
                                          color: kSecondaryColor),
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
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
