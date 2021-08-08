import 'package:final_dam_3/constants.dart';
import 'package:final_dam_3/services/auth_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailCtrl = new TextEditingController();
  TextEditingController passwordCtrl = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //     title: Text(
      //   "Login",
      //   style: TextStyle(fontFamily: manuscritoFontFamily, fontSize: 50),
      // )),
      body: SafeArea(
        child: Center(
          child: Column(children: [
            Container(
                width: double.infinity,
                child: CustomPaint(painter: _HeaderPainter())),
            Container(
              width: size.width * 0.7,
              height: size.height * 0.3,
              child: Center(
                  child: Column(children: [
                Spacer(),
                Text(
                  "Games N' news",
                  style: TextStyle(
                      fontFamily: manuscritoFontFamily,
                      fontSize: 60,
                      // fontWeight: FontWeight.bold,
                      color: kBackgroundColor),
                ),
                Text(
                  "Tu fuente de videojuegos.",
                  style: TextStyle(fontFamily: titulosFontFamily, fontSize: 20),
                ),
                Spacer()
              ])),
            ),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    color: Colors.white),
                width: size.width * 0.8,
                height: size.height * 0.5,
                // color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: Column(
                      children: [
                        Spacer(),
                        Text(
                          "Login Account",
                          style: TextStyle(
                              fontFamily: normalFontFamily,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        // Container(
                        //   margin: EdgeInsets.only(top: 10, bottom: 20),
                        //   alignment: Alignment.centerLeft,
                        //   child: FittedBox(
                        //     child: Text(
                        //       'Ingrese sus credenciales para iniciar sesión',
                        //       style: TextStyle(fontSize: 20),
                        //     ),
                        //   ),
                        // ),
                        Spacer(),
                        TextField(
                          controller: emailCtrl,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              labelText: "E-mail", focusColor: Colors.blue),
                        ),
                        TextField(
                          controller: passwordCtrl,
                          obscureText: true,
                          decoration: InputDecoration(labelText: "Password"),
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
                              AuthService authService = new AuthService();
                              authService.iniciarSesion(emailCtrl.text.trim(),
                                  passwordCtrl.text.trim());
                            },
                            child: Text("Ingresar"),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: size.height * 0.1,
                          child: Row(
                            children: [
                              // Container(
                              //   width: 300,
                              //   height: 100,
                              //   decoration: BoxDecoration(
                              //     shape: BoxShape.circle,
                              //   ),
                              //   child: Image.asset("assets\images\hongo.png"),
                              // )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // child: Text(
                  //   "Hola",
                  //   style:
                  //       TextStyle(fontFamily: manuscritoFontFamily, fontSize: 20),
                  // ),
                )),
            Container(
                child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: "¿No tienes cuenta aún? ",
                      style: TextStyle(color: Colors.black, fontSize: 15)),
                  TextSpan(
                      text: "Registrarse.",
                      style: TextStyle(
                          color: kSecondaryColor,
                          fontSize: 15.5,
                          fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          print('abrir regist page');
                        }),
                ]),
              ),
            ))
          ]),
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
    canvas.drawCircle(Offset(200, 200), 320, paint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
