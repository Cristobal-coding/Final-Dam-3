import 'package:final_dam_3/services/firestore.dart';
import 'package:flutter/material.dart';

class NoticiasPage extends StatefulWidget {
  NoticiasPage({Key key}) : super(key: key);

  @override
  _NoticiasPageState createState() => _NoticiasPageState();
}

class _NoticiasPageState extends State<NoticiasPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        // child: StreamBuilder(
        //   stream: FireStoreService().productos(),
        //   builder: (context,snapshot),{
        //     if(!snapshot.hasData){
        //       return Center(child:CircularProgressIndicator(),)
        //   }
        //   child: ListView(
        //     children: [

        //     ],
        //   ),
        // ),
        );
  }
}
