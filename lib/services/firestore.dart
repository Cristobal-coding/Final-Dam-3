import 'package:cloud_firestore/cloud_firestore.dart';

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
}
