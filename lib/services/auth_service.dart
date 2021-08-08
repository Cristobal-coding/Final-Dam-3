import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User> get usuario {
    return _firebaseAuth.authStateChanges();
  }

  Future iniciarSesion(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setStringList(
          'user', [userCredential.user.uid, userCredential.user.email]);
      return userCredential.user;
    } on FirebaseAuthException catch (ex) {
      switch (ex.code) {
        case 'wrong-password':
          return Future.error('Credenciales incorrectas');
        case 'user-not-found':
          return Future.error('Credenciales incorrectas');
        case 'user-disabled':
          return Future.error('Cuenta disabled');
        default:
          return Future.error('Error desconocido');
      }
    }
  }

  Future cerrarSesion() async {
    return await _firebaseAuth.signOut();
  }

  Future createUser(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      SharedPreferences sp = await SharedPreferences.getInstance();
      sp.setStringList(
          'user', [userCredential.user.uid, userCredential.user.email]);
      return userCredential.user;
    } on FirebaseAuthException catch (ex) {
      switch (ex.code) {
        case 'weak-password':
          return Future.error('Password debe tener minimo 6 chars.');
        case 'email-already-in-use':
          return Future.error('Email ya está registrado.');
        default:
          return Future.error('Error al crear cuenta');
      }
    }
  }
}
