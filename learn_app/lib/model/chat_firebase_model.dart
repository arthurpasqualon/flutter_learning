import 'package:cloud_firestore/cloud_firestore.dart';

class ChatFirebaseModel {
  String message = '';
  String userId = '';
  String nickName = '';
  DateTime dateTime = DateTime.now();

  ChatFirebaseModel(
      {required this.message,
      required this.userId,
      required this.nickName,
      required this.dateTime});

  ChatFirebaseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    userId = json['userId'];
    nickName = json['nickName'];
    dateTime = (json['dateTime'] as Timestamp).toDate();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['userId'] = userId;
    data['nickName'] = nickName;
    data['dateTime'] = Timestamp.fromDate(dateTime);
    return data;
  }
}
