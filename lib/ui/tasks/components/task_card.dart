import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/ui/tasks/components/task_details_view.dart';

class TaskCard extends StatefulWidget {
  final String status;

  const TaskCard({Key key, this.status}) : super(key: key);

  @override
  _TaskCardState createState() => _TaskCardState(status);
}

class _TaskCardState extends State<TaskCard> {
  final String status;
  CollectionReference toDoStore =
      FirebaseFirestore.instance.collection('tasks');

  _TaskCardState(this.status);

  bool isToDo = false;
  bool isInProgress = false;
  bool isTesting = false;
  bool isDone = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: toDoStore.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        return ListView.builder(
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            if (snapshot.data.docs[index]['status'] == status) {
              return Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskDetailsView(
                          docs: snapshot.data.docs,
                          index: index,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                    color: Colors.grey[300],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Названия: ${snapshot.data.docs[index]["task_name"]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Автор: ${snapshot.data.docs[index]['author']}",
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "ID: ${snapshot.data.docs[index]['id']}",
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            return Container();
          },
        );
      },
    );
  }
}
