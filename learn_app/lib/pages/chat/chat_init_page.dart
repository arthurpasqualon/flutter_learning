import 'package:flutter/material.dart';
import 'package:learn_app/pages/chat/chat_page.dart';

class ChatInitPage extends StatelessWidget {
  const ChatInitPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nickNameController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Start Chat'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: nickNameController,
                decoration: const InputDecoration(
                  hintText: 'Enter your nickname',
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                onPressed: () {
                  debugPrint(nickNameController.text);
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ChatPage(nickName: nickNameController.text);
                  }));
                },
                child: const Text('Enter Chat'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
