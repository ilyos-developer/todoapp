import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TaskDetailsView extends StatelessWidget {
  final List<QueryDocumentSnapshot> docs;
  final int index;

  const TaskDetailsView({Key key, this.docs, this.index}) : super(key: key);

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
            SizedBox(height: 15),
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
                  "Автор: ${docs[index]["author"]}",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
