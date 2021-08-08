import 'package:final_dam_3/pages/login_page.dart';
import 'package:final_dam_3/pages/navegador.dart';
import 'package:final_dam_3/pages/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BasePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final usuario = Provider.of<User>(context);
    // return usuario == null ? LoginPage() : MainNav();
    return RegisterPage();
  }
}
