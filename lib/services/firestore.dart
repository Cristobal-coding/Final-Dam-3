import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FireStoreService {
  Stream<QuerySnapshot> juegos() {
    return FirebaseFirestore.instance.collection('juegos').snapshots();
  }

  Stream<QuerySnapshot> allNoticias() {
    return FirebaseFirestore.instance.collection('news').snapshots();
  }

  Stream<QuerySnapshot> myNoticias(String uid) {
    return FirebaseFirestore.instance
        .collection('news')
        .where('uid', isEqualTo: uid)
        .snapshots();
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

  Future removeItemWish(String id) async {
    FirebaseFirestore.instance.collection('deseos').doc(id).delete();
  }

  Stream<QuerySnapshot> checkIsWish(String id, uid) {
    return FirebaseFirestore.instance
        .collection('deseos')
        .where('uid', isEqualTo: uid)
        .where('id_producto', isEqualTo: id)
        .snapshots();
  }

  Future addNew(String titulo, url, descripcion, bool hidden) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    FirebaseFirestore.instance.collection('news').doc().set({
      'fecha': DateTime.now(),
      'descripcion': descripcion,
      'img': url,
      'titulo': titulo,
      'hidden': hidden,
      'uid': sp.getStringList('user')[0],
    });
  }

  Future borrarNew(String noticiaId) async {
    FirebaseFirestore.instance.collection('news').doc(noticiaId).delete();
  }
}
