import 'package:flutter/material.dart';

class ToDoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: "add new task",
        onPressed: () {
          print("task add");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
