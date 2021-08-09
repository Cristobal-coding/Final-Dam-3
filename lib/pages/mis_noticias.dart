import 'package:final_dam_3/constants.dart';
import 'package:final_dam_3/pages/add_noticias.dart';
import 'package:final_dam_3/pages/ud_noticia.dart';
import 'package:final_dam_3/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MisNoticiasPage extends StatefulWidget {
  MisNoticiasPage({Key key, this.uid}) : super(key: key);
  final String uid;
  @override
  _MisNoticiasPageState createState() => _MisNoticiasPageState();
}

class _MisNoticiasPageState extends State<MisNoticiasPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var dateFormat = new DateFormat('dd-MM-yyyy hh:mm');
    return Scaffold(
      appBar: AppBar(title: Text("Mis noticias")),
      body: Container(
        child: Column(children: [
          Expanded(
            child: Stack(children: [
              Expanded(
                child: StreamBuilder(
                    stream: FireStoreService().myNoticias(widget.uid),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ListView.separated(
                        separatorBuilder: (_, __) => Divider(),
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (context, index) {
                          var noticia = snapshot.data.docs[index];

                          return Container(
                            width: double.infinity,
                            height: size.height * 0.4,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onLongPress: () {
                                        MaterialPageRoute route =
                                            new MaterialPageRoute(
                                                builder: (context) =>
                                                    UDNoticiaPage(
                                                        id: noticia.id,
                                                        description: noticia[
                                                            'descripcion'],
                                                        hidden:
                                                            noticia['hidden'],
                                                        img: noticia['img'],
                                                        titulo:
                                                            noticia['titulo'],
                                                        uid: widget.uid));
                                        Navigator.push(context, route);
                                      },
                                      child: Container(
                                        width: double.infinity,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: FittedBox(
                                              fit: BoxFit.fill,
                                              child: Image.network(
                                                  noticia['img'])),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: size.height * 0.11,
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.all(7.0),
                                    child: Column(
                                      children: [
                                        Row(children: [
                                          Container(
                                              width: size.width * 0.5,
                                              child: Text(
                                                noticia['titulo'],
                                                style: TextStyle(
                                                    fontFamily:
                                                        titulosFontFamily,
                                                    fontSize: 20),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                              )),
                                          Container(
                                              child: Text(
                                            (noticia['hidden'] == true)
                                                ? 'Aún no se ha publicado'
                                                : '',
                                            style: TextStyle(color: kRedColor),
                                          ))
                                        ]),
                                        Row(children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              width: size.width * 0.75,
                                              height: size.height * 0.05,
                                              child: Text(
                                                noticia['descripcion'],
                                                style: TextStyle(fontSize: 16),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Container(
                                              width: size.width * 0.2,
                                              height: size.height * 0.05,
                                              child: Text(
                                                "${dateFormat.format(DateTime.parse(noticia['fecha'].toDate().toString()))} hrs.",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: kRedColor),
                                                textAlign: TextAlign.right,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                              ),
                                            ),
                                          ),
                                        ]),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    child: FloatingActionButton(
                      onPressed: () {
                        MaterialPageRoute route = new MaterialPageRoute(
                            builder: (context) => AddNoticiasPage());
                        Navigator.push(context, route);
                      },
                      child: Icon(
                        Icons.add,
                      ),
                      backgroundColor: Colors.pink.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}