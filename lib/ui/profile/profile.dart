import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/service/auth.dart';

class ProfileScreen extends StatelessWidget {
  User user;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Профиль"),
        actions: [
          IconButton(
            icon: Icon(Icons.login),
            onPressed: () {
              AuthService().logOut();
            },
          ),
        ],
      ),
      body: Container(
        child: Center(child: Text("user.displayName")),
      ),
    );
  }
}
