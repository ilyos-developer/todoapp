import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/models/user.dart';

class AuthService {
  final FirebaseAuth _fAuth = FirebaseAuth.instance;
  User user;

  Future<MyUser> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _fAuth.signInWithEmailAndPassword(
          email: email, password: password);
      user = result.user;
      return MyUser.fromFireBase(user);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<MyUser> registerWithEmailAndPassword(
      String email, String password, String name, String familiya) async {
    try {
      UserCredential result = await _fAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      result.user.updateProfile(displayName: "$name $familiya");
      user = result.user;
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
    return _fAuth
        .authStateChanges()
        .map((User user) => user != null ? MyUser.fromFireBase(user) : null);
  }

  Future<void> updateProfile({String newName, String newFamiliya}) async {
    user = _fAuth.currentUser;
    print("new profile name: $newName");
    await user.updateProfile(
      displayName: "$newName $newFamiliya",
    );
  }

  Future<void> updatePassword(String newPassword) async {
    user = _fAuth.currentUser;
    print("new password: $newPassword");
    await user.updatePassword(newPassword).then((_) {
      print("Successfully changed password");
    }).catchError((error) {
      print("Password can't be changed" + error.toString());
    });
  }
}
