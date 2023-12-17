import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final String email;
  const Profile({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Center(
        child: Text(email),
      ),
    );
  }
}
