import 'package:cloud_firestore/cloud_firestore.dart';

class TaskFirebaseModel {
  String description = '';
  String userId = '';
  DateTime createdAt = DateTime.now();
  DateTime updatedAt = DateTime.now();
  bool completed = false;

  TaskFirebaseModel(
      {required this.description,
      required this.completed,
      required this.createdAt,
      required this.updatedAt,
      required this.userId});

  TaskFirebaseModel.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    completed = json['completed'];
    userId = json['userId'];
    createdAt = (json['createdAt'] as Timestamp).toDate();
    updatedAt = (json['updatedAt'] as Timestamp).toDate();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['description'] = description;
    data['completed'] = completed;
    data['createdAt'] = Timestamp.fromDate(createdAt);
    data['updatedAt'] = Timestamp.fromDate(updatedAt);
    data['userId'] = userId;
    return data;
  }
}
