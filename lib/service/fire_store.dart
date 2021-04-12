import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FireStore {
  CollectionReference fireStore =
      FirebaseFirestore.instance.collection('tasks');
  final FirebaseAuth _fAuth = FirebaseAuth.instance;
  User user;

  Future<void> addTask(
      {String id, String taskName, String describe, String status}) {
    user = _fAuth.currentUser;
    return fireStore
        .doc(taskName)
        .set({
          'id': id,
          'task_name': taskName,
          'describe': describe,
          'author': user.displayName,
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
