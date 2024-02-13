import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:learn_app/model/chat_firebase_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class ChatPage extends StatefulWidget {
  final String nickName;
  const ChatPage({super.key, required this.nickName});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController messageController = TextEditingController(text: '');
  String userId = "";
  final db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    loadUserId();
  }

  void loadUserId() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    String? value = sharedPrefs.getString("userId");
    if (value == null) {
      value = const Uuid().v4();
      sharedPrefs.setString("userId", value);
    }
    setState(() {
      userId = value ?? "";
    });
  }

  void sendMessage() async {
    final message = messageController.text;
    if (message.isNotEmpty) {
      var messageData = ChatFirebaseModel(
        message: message,
        userId: userId,
        nickName: widget.nickName,
        dateTime: DateTime.now(),
      );
      await db.collection("chats").add(messageData.toJson());
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Page'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream:
                      db.collection("chats").orderBy("dateTime").snapshots(),
                  builder: (context, snapshot) => snapshot.hasData
                      ? ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          padding: const EdgeInsets.all(16),
                          itemBuilder: (context, index) {
                            var message = ChatFirebaseModel.fromJson(
                                snapshot.data!.docs[index].data()
                                    as Map<String, dynamic>);

                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                textColor: Colors.white,
                                title: Text(message.nickName),
                                tileColor: message.userId == userId
                                    ? Colors.blue
                                    : Colors.grey,
                                subtitle: Text(message.message),
                                trailing: Text(
                                  message.dateTime.toLocal().toString(),
                                  style: const TextStyle(fontSize: 10),
                                ),
                              ),
                            );
                          },
                        )
                      : const Center(
                          child: CircularProgressIndicator(),
                        )),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        style: const TextStyle(fontSize: 18),
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(12),
                          hintText: 'Enter your message',
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        sendMessage();
                      },
                      icon: const Icon(Icons.send),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
