import 'package:final_dam_3/services/firestore.dart';
import 'package:flutter/material.dart';

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
      appBar: AppBar(title: Text("Create a noticias")),
      body: Center(
        child: Column(children: [
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
                                  fontFamily: titulosFontFamily, fontSize: 40),
                            ),
                          ),
                          Spacer(),
                          TextFormField(
                            validator: (value) {
                              return null;
                            },
                            controller: tituloCtrl,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                                labelText: 'Titulo de la noticia'),
                          ),
                          TextFormField(
                            validator: (value) {
                              return null;
                            },
                            controller: imgCtrl,
                            decoration:
                                InputDecoration(labelText: 'Url de la imagen'),
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
        ]),
      ),
    );
  }
}
