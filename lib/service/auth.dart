import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/models/user.dart';

class AuthService {
  final FirebaseAuth _fAuth = FirebaseAuth.instance;

  Future<MyUser> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _fAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return MyUser.fromFireBase(user);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<MyUser> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _fAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      print(user.email);
      print(user.displayName);
      print(user.uid);
      return MyUser.fromFireBase(user);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future logOut() async {
    await _fAuth.signOut();
  }

  Stream<MyUser> get currentUser {
   return _fAuth.authStateChanges().map((User user) => user != null ? MyUser.fromFireBase(user) : null);
  }

  Future<void> updateProfile(String userName) async {
    User user;
    await user.updateProfile(
      displayName: userName,
    );
  }
}
