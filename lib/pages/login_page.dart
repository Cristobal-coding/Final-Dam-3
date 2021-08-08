import 'package:final_dam_3/constants.dart';
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
                height: size.height * 0.3,
                width: double.infinity,
                child: CustomPaint(painter: _HeaderPainter())),
            Container(child: Text("Hola")),
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
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: StadiumBorder(),
                              primary: kSecondaryColor,
                            ),
                            onPressed: () {},
                            child: Text("Ingresar"),
                          ),
                        )
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
                child: RichText(
              text: TextSpan(children: <TextSpan>[
                TextSpan(text: "No tienes cuenta aún?"),
                TextSpan(text: "Registrarse.")
              ]),
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
    paint.strokeWidth = 10;

    final path = new Path();
    // path.lineTo(0, size.height * 3);
    // path.lineTo(size.width, size.height * 3);
    canvas.drawCircle(Offset(200, 200), 320, paint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
