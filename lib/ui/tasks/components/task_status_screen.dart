import 'package:flutter/material.dart';
import 'package:todo_app/ui/tasks/components/add_task.dart';
import 'package:todo_app/ui/tasks/components/task_card.dart';

class TaskStatusScreen extends StatelessWidget {
  final String status;

  const TaskStatusScreen({Key key, this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TaskCard(status: status),
      floatingActionButton: status == "To Do"
          ? FloatingActionButton(
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
            )
          : null,
    );
  }
}
