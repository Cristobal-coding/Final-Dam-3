import 'package:final_dam_3/services/firestore.dart';
import 'package:flutter/material.dart';

class UDNoticiaPage extends StatefulWidget {
  UDNoticiaPage({
    Key key,
    this.id,
    this.description,
    this.hidden,
    this.img,
    this.titulo,
    this.uid,
  }) : super(key: key);
  final String id;
  final String description;
  final bool hidden;
  final String img;
  final String titulo;
  final String uid;

  @override
  _UDNoticiaPageState createState() => _UDNoticiaPageState();
}

class _UDNoticiaPageState extends State<UDNoticiaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Borrar una noticia"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              Text("Desear borrar la noticia ${widget.titulo}"),
              ElevatedButton(
                  onPressed: () {
                    FireStoreService().borrarNew(widget.id);
                    Navigator.of(context).pop();
                  },
                  child: Text("Borrar"))
            ],
          ),
        ),
      ),
    );
  }
}
