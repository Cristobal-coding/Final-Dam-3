import 'package:final_dam_3/services/firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShopPage extends StatefulWidget {
  ShopPage({Key key}) : super(key: key);

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
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
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.4,
      // color: Colors.red,
      child: Column(
        children: [
          Container(
            // width: double.infinity,
            height: size.height * 0.4,
            child: StreamBuilder(
              stream: FireStoreService().comprasByUid(uid),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                var compras = snapshot.data.docs;
                return ListView.separated(
                  itemCount: compras.length,
                  separatorBuilder: (_, __) => Divider(),
                  itemBuilder: (context, index) {
                    // print(compras[index]['id_juego']);
                    return StreamBuilder(
                      stream: FireStoreService().getItemById(
                          compras[index]['id_juego'], compras[index]['isGame']),
                      builder: (context, snapshotTwo) {
                        if (!snapshotTwo.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }
                        var compra = snapshotTwo.data.docs;
                        print(compra);
                        return ListTile(
                          title: Text('${compra[0]['nombre']}'),
                          // title: compras[index]['isGame']
                          //     ? Text('Juego')
                          //     : Text('HardWare'),
                          subtitle: Text('${compras[index]['cost']}'),
                          trailing: Text('${compras[index]['cost']}'),
                        );
                      },
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
