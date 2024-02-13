import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:learn_app/pages/chat/chat_page.dart';

class ChatInitPage extends StatelessWidget {
  const ChatInitPage({super.key});

  @override
  Widget build(BuildContext context) {
    final remoteConfig = FirebaseRemoteConfig.instance;
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    final hintText = remoteConfig.getString('chat_screen_title');
    TextEditingController nickNameController = TextEditingController();

    void sendAnalyticsEvent() async {
      await analytics.logEvent(name: 'chat_init_page_view');
    }

    sendAnalyticsEvent();
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
                decoration: InputDecoration(
                  hintText: hintText,
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
