import 'package:final_dam_3/constants.dart';
import 'package:final_dam_3/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopPage extends StatefulWidget {
  ShopPage({Key key}) : super(key: key);

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  String uid = '';
  var formato =
      NumberFormat.currency(decimalDigits: 0, locale: 'es-CL', symbol: '');
  var dateFormat = new DateFormat('dd-MM-yyyy kk:mm');

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
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      // height: size.height * 0.40,
      // color: Colors.blue,
      child: Column(
        children: [
          Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                MdiIcons.currencyUsd,
                color: kGreenColor,
              ),
              Text(
                'Articulos comprados',
                style: TextStyle(fontSize: 23, fontFamily: titulosFontFamily),
              ),
            ],
          )),
          Container(
            height: size.height * 0.4,
            child: StreamBuilder(
              stream: FireStoreService().comprasByUid(uid),
              builder: (context, snapshot) {
                if (!snapshot.hasData ||
                    snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                var compras = snapshot.data.docs;
                if (compras.length == 0) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Text('Aun no has comprado ningún articulo'),
                  );
                }
                return ListView.separated(
                  itemCount: compras.length,
                  separatorBuilder: (_, __) => Divider(),
                  itemBuilder: (context, index) {
                    return StreamBuilder(
                      stream: FireStoreService().getItemById(
                          compras[index]['id_juego'], compras[index]['isGame']),
                      builder: (context, snapshotTwo) {
                        if (!snapshotTwo.hasData ||
                            snapshotTwo.connectionState ==
                                ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        var compra = snapshotTwo.data.docs;
                        return ListTile(
                          title: Text(
                            '${compra[0]['nombre']}',
                            style: TextStyle(fontFamily: titulosFontFamily),
                          ),
                          subtitle: compras[index]['isGame'] == true
                              ? Text(
                                  'Desarrollador: ${compra[0]['desarrollador']}')
                              : Text('Tipo: ${compra[0]['tipo']}'),
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '-\$${formato.format(compras[index]['cost'])}',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: manuscritoFontFamily,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '${dateFormat.format(DateTime.parse(compras[index]['fecha'].toDate().toString()))}',
                                style: TextStyle(
                                  fontFamily: titulosFontFamily,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
          Container(
              padding: EdgeInsets.all(8.0),
              height: size.height * 0.05,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    MdiIcons.heart,
                    color: Colors.red,
                  ),
                  Text(
                    'Lista de deseos',
                    style:
                        TextStyle(fontSize: 23, fontFamily: titulosFontFamily),
                  ),
                ],
              )),
          Container(
            height: size.height * 0.32,
            // color: Colors.red,
            child: StreamBuilder(
              stream: FireStoreService().deseosByUid(uid),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                var deseos = snapshot.data.docs;
                if (deseos.length == 0) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                    child: Text('No hay elementos en la Lista de deseos'),
                  );
                }
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: deseos.length,
                  itemBuilder: (context, index) {
                    return StreamBuilder(
                      stream: FireStoreService().getItemById(
                          deseos[index]['id_producto'],
                          deseos[index]['isGame']),
                      builder: (context, snapshotTwo) {
                        if (!snapshotTwo.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }
                        var deseo = snapshotTwo.data.docs;
                        return Container(
                          height: size.height * 0.25,
                          margin: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30.0),
                                    child: Image.network(
                                      deseo[0]['img'],
                                      width: 200,
                                      height: 220,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Positioned(
                                    right: 0,
                                    child: IconButton(
                                      icon: Icon(
                                        MdiIcons.closeCircle,
                                        size: 35,
                                        color: kSecondaryColor,
                                      ),
                                      onPressed: () {
                                        FireStoreService()
                                            .removeItemWish(deseos[index].id);
                                      },
                                    ),
                                  )
                                ],
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: kPrimaryColor),
                                onPressed: () {
                                  FireStoreService().addCompraFromWish(
                                      deseo[0].id,
                                      deseos[index].id,
                                      deseo[0]['precio'],
                                      deseos[index]['isGame']);
                                },
                                child: Text(
                                    'Comprar \$${formato.format(deseo[0]['precio'])}'),
                              )
                            ],
                          ),
                        );
                      },
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
