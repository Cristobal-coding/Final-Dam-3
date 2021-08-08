import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Text("Menu"),
          ),
          ListTile(
            onTap: () {},
            title: Text("Cerrar Sesion"),
            leading: Icon(MdiIcons.sword),
          ),
          ListTile(
            onTap: () {},
            title: Text("Cerrar Sesion"),
            leading: Icon(MdiIcons.sword),
          ),
          ListTile(
            onTap: () {},
            title: Text("Cerrar Sesion"),
            leading: Icon(MdiIcons.sword),
          )
        ],
      ),
    );
  }
}
