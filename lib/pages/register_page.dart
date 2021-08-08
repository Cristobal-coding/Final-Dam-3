import 'package:flutter/material.dart';

import '../constants.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailCtrl = new TextEditingController();
  TextEditingController pass1Ctrl = new TextEditingController();
  TextEditingController pass2Ctrl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Column(children: [
          Container(
              width: double.infinity,
              child: CustomPaint(painter: _HeaderPainter())),
          Container(child: Text("Registrar nuevo user.")),
          Container(
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(40)),
              width: size.width * 0.8,
              height: size.height * 0.6,
              child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Spacer(),
                        Container(
                          child: Text(
                            "Crear una cuenta",
                            style: TextStyle(
                                fontFamily: titulosFontFamily, fontSize: 30),
                          ),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Ingrese un email';
                            }
                            if (RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value)) {
                              return null;
                            } else {
                              return 'Ingrese un formato de email valido';
                            }
                          },
                          controller: emailCtrl,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(labelText: 'Email'),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Ingrese una contraseña';
                            }
                            return null;
                          },
                          controller: pass1Ctrl,
                          obscureText: true,
                          decoration: InputDecoration(labelText: 'Password'),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Ingrese una contraseña';
                            }
                            if (value != pass1Ctrl.text.trim()) {
                              return 'Las contraseñas deben coincidir';
                            }
                            return null;
                          },
                          controller: pass2Ctrl,
                          keyboardType: TextInputType.emailAddress,
                          decoration:
                              InputDecoration(labelText: 'Repita su password'),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState.validate()) {}
                            },
                            child: Text("Crear cuenta.")),
                        Spacer(),
                      ],
                    ),
                  ))),
        ]),
      ),
    ));
  }
}

class _HeaderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = kGreenColor;
    paint.style = PaintingStyle.fill;

    final path = new Path();
    canvas.drawCircle(Offset(200, 200), 320, paint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
