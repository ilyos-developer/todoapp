import 'package:cloud_firestore/cloud_firestore.dart';

class FireStore {
  CollectionReference fireStore =
      FirebaseFirestore.instance.collection('to_do');

  Future<void> addTask(
      {String id, String taskName, String describe, String status}) {
    return fireStore
        .doc(taskName)
        .set({
          'id': id,
          'task_name': taskName,
          'describe': describe,
          'author': "ilyos",
          'status': status
        })
        .then((value) => print("task Added"))
        .catchError((error) => print("Failed to add task: $error"));
  }

  Future<void> updateStatus({String taskName, String status}) {
    return fireStore
        .doc(taskName)
        .update({'status': status})
        .then((value) => print("status Updated"))
        .catchError((error) => print("Failed to update status: $error"));
  }
}
