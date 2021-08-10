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
  final _formKey = GlobalKey<FormState>();
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

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Editar mi noticia",
          style: TextStyle(fontFamily: manuscritoFontFamily, fontSize: 40),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            height: size.height * 0.8,
            child: Column(children: [
              Container(
                  width: double.infinity,
                  child: CustomPaint(painter: _HeaderPainter())),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.white),
                height: size.height * 0.65,
                width: double.infinity,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Spacer(),
                      TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Ingrese un texto';
                          }
                          return null;
                        },
                        controller: nuevoTituloCtrl,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Titulo de la noticia',
                          labelStyle: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: kPrimaryColor),
                        ),
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
                          style: TextStyle(fontSize: 20),
                          controller: nuevoURLCtrl,
                          decoration: InputDecoration(
                            labelText: 'Url de la imagen',
                            labelStyle: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          )),
                      TextFormField(
                          validator: (value) {
                            return null;
                          },
                          style: TextStyle(fontSize: 20),
                          controller: nuevoDescripcionCtrl,
                          maxLines: 3,
                          maxLength: 90,
                          decoration: InputDecoration(
                            labelText: 'Descripcion de la noticia',
                            labelStyle: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          )),
                      Row(
                        children: [
                          Text(
                            "Oculto",
                            style: TextStyle(
                                fontSize: 20,
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold),
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
                      Spacer(),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: StadiumBorder(),
                              primary: kPrimaryColor,
                            ),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                FireStoreService().updateNew(
                                    widget.id,
                                    nuevoTituloCtrl.text.trim(),
                                    nuevoDescripcionCtrl.text.trim(),
                                    nuevoURLCtrl.text.trim(),
                                    hiddenChecked[0]);
                                Navigator.of(context).pop();
                              }
                            },
                            child: Text("Editar titulo")),
                      )
                    ],
                  ),
                ),
              ),
              Spacer(
                flex: 2,
              ),
              Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(),
                      primary: kPrimaryColor,
                    ),
                    child: Text("Borrar noticia"),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                title: Text(
                                    "Desear borrar la noticia ${widget.titulo}"),
                                content: Text("Confirmar borrado."),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      FireStoreService().borrarNew(widget.id);
                                      Navigator.pop(context, 'OK');
                                      Navigator.pop(context);
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              ));
                    },
                  )),
            ]),
          ),
        ),
      ),
    );
  }
}

class _HeaderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = kPrimaryColor;
    paint.style = PaintingStyle.fill;

    final path = new Path();
    canvas.drawCircle(Offset(200, 200), 370, paint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
