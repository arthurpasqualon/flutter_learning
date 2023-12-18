import 'package:flutter/material.dart';

class Section extends StatelessWidget {
  final String text;
  const Section({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        const SizedBox(height: 16),
        Text(text,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
      ],
    );
  }
}
