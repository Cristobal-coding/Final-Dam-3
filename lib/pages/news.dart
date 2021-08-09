import 'package:final_dam_3/constants.dart';
import 'package:final_dam_3/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NoticiasPage extends StatefulWidget {
  NoticiasPage({Key key}) : super(key: key);

  @override
  _NoticiasPageState createState() => _NoticiasPageState();
}

class _NoticiasPageState extends State<NoticiasPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var dateFormat = new DateFormat('dd-MM-yyyy hh:mm');
    return Container(
      child: Column(children: [
        Expanded(
          child: Stack(children: [
            Expanded(
              child: StreamBuilder(
                  stream: FireStoreService().noticias(),
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
                        if (!noticia['hidden']) {
                          return Container(
                            width: double.infinity,
                            height: size.height * 0.4,
                            child: Column(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {},
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
                                  height: size.height * 0.1,
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.all(7.0),
                                    child: Column(
                                      children: [
                                        Container(
                                            width: double.infinity,
                                            child: Text(
                                              noticia['titulo'],
                                              style: TextStyle(
                                                  fontFamily: titulosFontFamily,
                                                  fontSize: 20),
                                            )),
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
                        } else {
                          return null;
                        }
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
                      // Add your onPressed code here!
                    },
                    child: Icon(
                      Icons.add,
                    ),
                    backgroundColor: Colors.pink,
                  ),
                ),
              ),
            ),
          ]),
        ),
      ]),
    );
  }
}
