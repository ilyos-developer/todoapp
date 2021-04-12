import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/bottom_nav_bar.dart';
import 'package:todo_app/models/user.dart';
import 'package:todo_app/ui/auth/login_page.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MyUser myUser = Provider.of<MyUser>(context);
    final bool isLoggedIn = myUser != null;
    return isLoggedIn ? BottomNavBar() : LoginPage();
  }
}
