import 'package:flutter/material.dart';
import 'package:learn_app/services/app_storage_service.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  AppStorageService storage = AppStorageService();

  bool receiveNotification = false;
  bool darkMode = false;

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  void loadSettings() async {
    receiveNotification = await storage.receiveNotification;
    darkMode = await storage.isDarkMode;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    void navigateBack() {
      Navigator.pop(context);
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Settings Page"),
        ),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            SwitchListTile(
                title: const Text("Receive Notification"),
                value: receiveNotification,
                onChanged: (value) {
                  setState(() {
                    receiveNotification = value;
                  });
                }),
            SwitchListTile(
                title: const Text("Dark Mode"),
                value: darkMode,
                onChanged: (value) {
                  setState(() {
                    darkMode = value;
                  });
                }),
            const SizedBox(height: 16),
            const SizedBox(height: 16),
            TextButton(
                onPressed: () async {
                  // Close keyboard
                  FocusManager.instance.primaryFocus?.unfocus();

                  // Save settings
                  await storage.setReceiveNotification(receiveNotification);
                  await storage.setDarkMode(darkMode);
                  navigateBack();
                },
                style: TextButton.styleFrom(backgroundColor: Colors.black),
                child: const Text("Save",
                    style: TextStyle(color: Colors.white, fontSize: 22)))
          ],
        ),
      ),
    );
  }
}
