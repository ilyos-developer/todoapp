import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/service/fire_store.dart';

class TaskDetailsView extends StatefulWidget {
  final List<QueryDocumentSnapshot> docs;
  final int index;

  const TaskDetailsView({Key key, this.docs, this.index}) : super(key: key);

  @override
  _TaskDetailsViewState createState() => _TaskDetailsViewState(docs, index);
}

class _TaskDetailsViewState extends State<TaskDetailsView> {
  final List<QueryDocumentSnapshot> docs;
  final int index;

  String dropdownValue;

  _TaskDetailsViewState(this.docs, this.index);

  List<String> statusList = ["To Do", "In Progress", "Testing", "Done"];

  @override
  void initState() {
    super.initState();
    dropdownValue = docs[index]["status"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(docs[index]["task_name"]),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Названия: ${docs[index]["task_name"]}",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            Text(
              "Описания: ${docs[index]["describe"]}",
              style: TextStyle(
                fontSize: 22,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "ID: ${docs[index]["id"]}",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 18,
                  ),
                ),
                Spacer(),
                Text(
                  "Названия: ${docs[index]["author"]}",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Статус:",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(width: 15),
                DropdownButton(
                  value: dropdownValue,
                  onChanged: (value) {
                    setState(() {
                      dropdownValue = value;
                      FireStore().updateStatus(
                          taskName: docs[index]["task_name"],
                          status: dropdownValue);
                    });
                  },
                  items: statusList.map(
                    (item) {
                      return DropdownMenuItem(
                        value: item,
                        child: Text(
                          item,
                          style: TextStyle(fontSize: 16),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
