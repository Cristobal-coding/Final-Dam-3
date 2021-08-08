import 'package:convex_bottom_navigation/convex_bottom_navigation.dart';
import 'package:final_dam_3/components/side_menu.dart';
import 'package:final_dam_3/constants.dart';
import 'package:final_dam_3/pages/games.dart';
import 'package:final_dam_3/pages/news.dart';
import 'package:final_dam_3/pages/shopping.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainNav extends StatefulWidget {
  MainNav({Key key}) : super(key: key);

  @override
  _MainNavState createState() => _MainNavState();
}

class _MainNavState extends State<MainNav> {
  int _currentIndex = 0;
  List<Widget> _pages = [JuegosPage(), NoticiasPage(), ShopPage()];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        title: Text(
          'Hola',
          style: TextStyle(fontFamily: manuscritoFontFamily, fontSize: 28),
        ),

        // leading: Icon(MdiIcons.firebase),
        // actions: [
        //   PopupMenuButton(
        //     onSelected: (option) {
        //       AuthService authService = new AuthService();
        //       authService.cerrarSesion();
        //     },
        //     itemBuilder: (context) =>
        //         [PopupMenuItem(value: 'salir', child: Text('Cerrar Sesion'))],
        //   )
        // ],
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: ConvexBottomNavigation(
        activeIconColor: kSecondaryColor,
        inactiveIconColor: Colors.grey,
        textColor: kSecondaryColor,
        bigIconPadding: 15.0,
        circleSize: CircleSize.BIG,
        smallIconPadding: 10.0,
        circleColor: Colors.white,
        tabs: [
          TabData(
            icon: const Icon(
              Icons.gamepad_sharp,
              color: kSecondaryColor,
              size: 30,
            ),
            title: "Juegos",
          ),
          TabData(
            icon: const Icon(
              MdiIcons.newspaper,
              color: kSecondaryColor,
              size: 30,
            ),
            title: "Noticias",
          ),
          TabData(
            icon: const Icon(
              MdiIcons.shopping,
              color: kSecondaryColor,
              size: 30,
            ),
            title: "Mis Productos",
          ),
        ],
        onTabChangedListener: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
      ),
    );
  }
}
