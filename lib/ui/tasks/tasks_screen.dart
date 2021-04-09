import 'package:flutter/material.dart';
import 'package:todo_app/ui/tasks/components/to_do_screen.dart';

class TasksScreen extends StatefulWidget {
  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                width: 4,
                color: Colors.white,
              ),
              insets: EdgeInsets.symmetric(horizontal: 15.0),
            ),
            isScrollable: true,
            tabs: [
              Container(
                margin: EdgeInsets.only(bottom: 15),
                child: Text(
                  "To Do",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 15),
                child: Text(
                  "In Progress",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 15),
                child: Text(
                  "Testing",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 15),
                child: Text(
                  "Done",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ToDoScreen(),
            Center(
              child: Text('In Progress'),
            ),
            Center(
              child: Text('Testing'),
            ),
            Center(
              child: Text('Done'),
            ),
          ],
        ),
      ),
    );
  }
}
