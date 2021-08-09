import 'package:final_dam_3/services/firestore.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

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
  TextEditingController nuevoTituloCtrl = new TextEditingController();
  TextEditingController nuevoDescripcionCtrl = new TextEditingController();
  TextEditingController nuevoURLCtrl = new TextEditingController();
  List<dynamic> hiddenChecked = [];
  @override
  void initState() {
    super.initState();
    nuevoTituloCtrl.text = widget.titulo;
    nuevoDescripcionCtrl.text = widget.description;
    nuevoURLCtrl.text = widget.img;
    hiddenChecked.add(widget.hidden);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Borrar una noticia",
          style: TextStyle(fontFamily: manuscritoFontFamily, fontSize: 40),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: size.height * 0.6,
            width: size.width * 0.85,
            child: Form(
              key: _formKey,
              child: Expanded(
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Ingrese un texto';
                        }
                        return null;
                      },
                      controller: nuevoTituloCtrl,
                      keyboardType: TextInputType.emailAddress,
                      decoration:
                          InputDecoration(labelText: 'Titulo de la noticia'),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (RegExp(
                                r'^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)')
                            .hasMatch(value)) {
                          return null;
                        } else {
                          return 'Ingrese una url valida.';
                        }
                      },
                      controller: nuevoURLCtrl,
                      decoration:
                          InputDecoration(labelText: 'Url de la imagen'),
                    ),
                    TextFormField(
                      validator: (value) {
                        return null;
                      },
                      controller: nuevoDescripcionCtrl,
                      maxLines: 3,
                      maxLength: 90,
                      decoration: InputDecoration(
                          labelText: 'Descripcion de la noticia'),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          "Oculto",
                          style: TextStyle(fontSize: 20),
                        ),
                        Checkbox(
                          value: hiddenChecked[0],
                          onChanged: (value) {
                            setState(() {
                              hiddenChecked[0] = value;
                              print(hiddenChecked[0]);
                            });
                          },
                        ),
                      ],
                    ),
                    // ElevatedButton(
                    //     onPressed: () {
                    //       if (_formKey.currentState.validate()) {
                    //         FireStoreService().updateNew(
                    //             widget.id,
                    //             nuevoTituloCtrl.text.trim(),
                    //             nuevoDescripcionCtrl.text.trim(),
                    //             nuevoURLCtrl.text.trim(),
                    //             hiddenChecked[0]);
                    //         Navigator.of(context).pop();
                    //       }
                    //     },
                    //     child: Text("Editar titulo"))
                  ],
                ),
              ),
            ),
          ),
          // Container(
          //     child: ElevatedButton(
          //   child: Text("Borrar noticia"),
          //   onPressed: () {
          //     showDialog(
          //         context: context,
          //         builder: (BuildContext context) => AlertDialog(
          //               title:
          //                   Text("Desear borrar la noticia ${widget.titulo}"),
          //               content: Text("Confirmar borrado."),
          //               actions: <Widget>[
          //                 TextButton(
          //                   onPressed: () => Navigator.pop(context, 'Cancel'),
          //                   child: const Text('Cancel'),
          //                 ),
          //                 TextButton(
          //                   onPressed: () {
          //                     FireStoreService().borrarNew(widget.id);
          //                     Navigator.pop(context, 'OK');
          //                     Navigator.pop(context);
          //                   },
          //                   child: const Text('OK'),
          //                 ),
          //               ],
          //             ));
          //   },
          // )),
        ]),
      ),
    );
  }
}
