import 'package:final_dam_3/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../constants.dart';

class AddNoticiasPage extends StatefulWidget {
  AddNoticiasPage({Key key}) : super(key: key);

  @override
  _AddNoticiasPageState createState() => _AddNoticiasPageState();
}

class _AddNoticiasPageState extends State<AddNoticiasPage> {
  @override
  final _formKey = GlobalKey<FormState>();
  TextEditingController tituloCtrl = new TextEditingController();
  TextEditingController imgCtrl = new TextEditingController();
  TextEditingController descripcionCtrl = new TextEditingController();
  TextEditingController fechaCtrl = new TextEditingController();
  bool _hidden = false;
  String errorText = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Create a noticias",
            style: TextStyle(
              fontFamily: manuscritoFontFamily,
              fontSize: 30,
            )),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(children: [
        Container(
            width: double.infinity,
            child: CustomPaint(painter: _HeaderPainter())),
        Expanded(
          child: Center(
            child: Column(children: [
              Spacer(),
              SingleChildScrollView(
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40)),
                    width: size.width * 0.8,
                    height: size.height * 0.65,
                    child: Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              Spacer(),
                              Container(
                                child: Text(
                                  "Crear una Noticia",
                                  style: TextStyle(
                                      fontFamily: titulosFontFamily,
                                      fontSize: 40),
                                ),
                              ),
                              Spacer(),
                              TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Ingrese un texto';
                                  }
                                  return null;
                                },
                                controller: tituloCtrl,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    labelText: 'Titulo de la noticia'),
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
                                controller: imgCtrl,
                                decoration: InputDecoration(
                                    labelText: 'Url de la imagen'),
                              ),
                              TextFormField(
                                validator: (value) {
                                  return null;
                                },
                                controller: descripcionCtrl,
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
                                    value: _hidden,
                                    onChanged: (value) {
                                      setState(() {
                                        _hidden = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              Container(
                                width: double.infinity,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: StadiumBorder(),
                                      primary: kSecondaryColor,
                                    ),
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        FireStoreService().addNew(
                                            tituloCtrl.text.trim(),
                                            imgCtrl.text.trim(),
                                            descripcionCtrl.text.trim(),
                                            _hidden);
                                        Navigator.of(context).pop();
                                      }
                                    },
                                    child: Text("Crear Noticia.")),
                              ),
                              Spacer(),
                              Container(
                                child: Text(
                                  "$errorText",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        ))),
              ),
              Spacer(),
            ]),
          ),
        ),
      ]),
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
    canvas.drawCircle(Offset(200, 200), 400, paint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
