import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FireStoreService {
  Stream<QuerySnapshot> juegos() {
    return FirebaseFirestore.instance.collection('juegos').snapshots();
  }

  Stream<QuerySnapshot> noticias() {
    return FirebaseFirestore.instance.collection('news').snapshots();
  }

  Stream<QuerySnapshot> hardware() {
    return FirebaseFirestore.instance.collection('hardware').snapshots();
  }

  Future toListWish(String idProd) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    FirebaseFirestore.instance.collection('deseos').doc().set({
      'añadido': DateTime.now(),
      'id_producto': idProd,
      'uid': sp.getStringList('user')[0],
    });
  }
}
