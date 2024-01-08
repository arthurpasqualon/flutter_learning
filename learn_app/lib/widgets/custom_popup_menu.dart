import 'package:flutter/material.dart';

class CustomPopupMenu extends StatelessWidget {
  const CustomPopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 1,
          child: Text("Edit"),
        ),
        const PopupMenuItem(
          value: 2,
          child: Text("Delete"),
        ),
      ],
    );
  }
}
