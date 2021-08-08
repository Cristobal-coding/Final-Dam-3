import 'package:final_dam_3/constants.dart';
import 'package:final_dam_3/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({
    Key key,
  }) : super(key: key);

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  String emailUser = '';

  @override
  void initState() {
    this.cargarDatosUsuario();
    super.initState();
  }

  Future cargarDatosUsuario() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    setState(() {
      emailUser = sp.getStringList('user')[1];
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Drawer(
        child: ListView(
          children: [
            Container(
              height: (size.height) * 0.4,
              child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                  ),
                  child: Column(
                    children: [
                      Container(
                        child: Text("Menu de usuario",
                            style: TextStyle(
                                fontFamily: titulosFontFamily,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.white)),
                      ),
                      Spacer(),
                      Container(
                          width: size.width * 0.75,
                          child: FittedBox(
                            child: Text(
                              " $emailUser ",
                              style:
                                  TextStyle(fontSize: 23, color: Colors.white),
                            ),
                          )),
                      Spacer(),
                      CircleAvatar(
                        radius: 70.0,
                        backgroundImage:
                            NetworkImage('https://via.placeholder.com/150'),
                        backgroundColor: Colors.transparent,
                      ),
                      Spacer(),
                    ],
                  )),
            ),
            ListTile(
              onTap: () {},
              title: Text("Mis noticias"),
              leading: Icon(MdiIcons.newspaperVariantMultipleOutline),
            ),
            ListTile(
              onTap: () {},
              title: Text("Item"),
              leading: Icon(MdiIcons.sword),
            ),
            ListTile(
              onTap: () {
                AuthService authService = new AuthService();
                authService.cerrarSesion();
              },
              title: Text("Cerrar Sesion"),
              leading: Icon(MdiIcons.logout),
            )
          ],
        ),
      ),
    );
  }
}
