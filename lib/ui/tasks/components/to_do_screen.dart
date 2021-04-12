import 'package:flutter/material.dart';
import 'package:todo_app/ui/tasks/components/add_task.dart';
import 'package:todo_app/ui/tasks/components/task_card.dart';

class ToDoScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TaskCard(),
      floatingActionButton: FloatingActionButton(
        tooltip: "add new task",
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTask(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
