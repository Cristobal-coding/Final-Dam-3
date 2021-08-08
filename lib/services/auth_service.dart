import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User> get usuario {
    return _firebaseAuth.authStateChanges();
  }

  Future<User> iniciarSesion(String email, String password) async {
    UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredential.user;
  }

  Future cerrarSesion() async {
    return await _firebaseAuth.signOut();
  }
}
