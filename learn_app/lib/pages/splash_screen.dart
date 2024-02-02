import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:learn_app/pages/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topRight,
              colors: [Colors.red, Colors.blue]),
        ),
        child: Center(
            child: AnimatedTextKit(
          repeatForever: false,
          isRepeatingAnimation: false,
          pause: const Duration(milliseconds: 50),
          onFinished: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const LoginPage()));
          },
          animatedTexts: [
            TypewriterAnimatedText(
              'Welcome to Heroes App!',
              textStyle: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
              speed: const Duration(milliseconds: 100),
            ),
          ],
        )),
      ),
    );
  }
}
