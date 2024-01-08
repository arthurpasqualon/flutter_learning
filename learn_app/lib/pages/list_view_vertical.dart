import 'package:flutter/material.dart';
import 'package:learn_app/shared/app_images.dart';
import 'package:learn_app/widgets/custom_popup_menu.dart';

class ListViewVertical extends StatelessWidget {
  const ListViewVertical({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: Image.asset(AppImages.avatar, height: 72, width: 72),
          title: const Text("Home"),
          subtitle: const Text("Home Page"),
          contentPadding: const EdgeInsets.all(8),
          trailing: const CustomPopupMenu(),
        ),
        ListTile(
          leading: Image.asset(AppImages.avatar, height: 72, width: 72),
          title: const Text("Home"),
          subtitle: const Text("Home Page"),
          contentPadding: const EdgeInsets.all(8),
          trailing: const CustomPopupMenu(),
        ),
        ListTile(
          leading: Image.asset(AppImages.avatar, height: 72, width: 72),
          title: const Text("Home"),
          subtitle: const Text("Home Page"),
          contentPadding: const EdgeInsets.all(8),
          trailing: const CustomPopupMenu(),
        ),
        ListTile(
          leading: Image.asset(AppImages.avatar, height: 72, width: 72),
          title: const Text("Home"),
          subtitle: const Text("Home Page"),
          contentPadding: const EdgeInsets.all(8),
          trailing: const CustomPopupMenu(),
        ),
      ],
    );
  }
}
