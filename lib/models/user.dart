import 'package:firebase_auth/firebase_auth.dart';

class MyUser {
  String id;
  String name;
  String email;

  MyUser.fromFireBase(User user) {
    id = user.uid;
    name = user.displayName;
    email = user.email;
  }
}
