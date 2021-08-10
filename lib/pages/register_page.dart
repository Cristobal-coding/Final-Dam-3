import 'package:final_dam_3/pages/login_page.dart';
import 'package:final_dam_3/services/auth_service.dart';
import 'package:flutter/gestures.dart';
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
  String errorText = '';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Center(
            child: Column(children: [
              Container(
                  width: double.infinity,
                  child: CustomPaint(painter: _HeaderPainter())),
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
                                  "Crear una cuenta",
                                  style: TextStyle(
                                      fontFamily: titulosFontFamily,
                                      fontSize: 40),
                                ),
                              ),
                              Spacer(),
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
                                decoration:
                                    InputDecoration(labelText: 'Password'),
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
                                obscureText: true,
                                decoration: InputDecoration(
                                    labelText: 'Repita su password'),
                              ),
                              Spacer(),
                              Container(
                                width: double.infinity,
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: StadiumBorder(),
                                      primary: kSecondaryColor,
                                    ),
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        AuthService authService =
                                            new AuthService();
                                        authService
                                            .createUser(emailCtrl.text.trim(),
                                                pass1Ctrl.text.trim())
                                            .then((value) =>
                                                Navigator.pop(context))
                                            .catchError((ex) {
                                          setState(() {
                                            errorText = ex.toString();
                                          });
                                        });
                                      }
                                    },
                                    child: Text("Crear cuenta.")),
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
              Container(
                  child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: RichText(
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(
                        text: "¿Ya estás registrado? ",
                        style: TextStyle(color: Colors.black, fontSize: 15)),
                    TextSpan(
                        text: "Log in.",
                        style: TextStyle(
                            color: kSecondaryColor,
                            fontSize: 15.5,
                            fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pop(context);
                          }),
                  ]),
                ),
              )),
              Spacer(),
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
