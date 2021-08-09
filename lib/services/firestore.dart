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

  Stream<QuerySnapshot> comprasByUid(String uid) {
    return FirebaseFirestore.instance
        .collection('compras')
        .where('uid', isEqualTo: uid)
        .snapshots();
  }

  Stream<QuerySnapshot> deseosByUid(String uid) {
    return FirebaseFirestore.instance
        .collection('deseos')
        .where('uid', isEqualTo: uid)
        .snapshots();
  }

  Future toListWish(String idProd, bool isGame) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    FirebaseFirestore.instance.collection('deseos').doc().set({
      'añadido': DateTime.now(),
      'id_producto': idProd,
      'uid': sp.getStringList('user')[0],
      'isGame': isGame,
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

  Future addCompra(String id, int costo, bool isGame) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    FirebaseFirestore.instance.collection('compras').doc().set({
      'fecha': DateTime.now(),
      'id_juego': id,
      'uid': sp.getStringList('user')[0],
      'cost': costo,
      'isGame': isGame,
    });
  }

  Stream<QuerySnapshot> getItemById(String idProd, bool tipo) {
    if (tipo) {
      return FirebaseFirestore.instance
          .collection('juegos')
          .where(FieldPath.documentId, isEqualTo: idProd)
          .snapshots();
    } else {
      return FirebaseFirestore.instance
          .collection('hardware')
          .where(FieldPath.documentId, isEqualTo: idProd)
          .snapshots();
    }
  }
}
