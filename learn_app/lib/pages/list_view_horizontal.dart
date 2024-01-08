import 'package:flutter/material.dart';
import 'package:learn_app/shared/app_images.dart';

class ListViewHorizontal extends StatelessWidget {
  const ListViewHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Image.asset(
                  AppImages.avatar,
                  height: 96,
                  width: 96,
                ),
                Image.asset(
                  AppImages.avatar,
                  height: 96,
                  width: 96,
                ),
                Image.asset(
                  AppImages.avatar,
                  height: 96,
                  width: 96,
                ),
                Image.asset(
                  AppImages.avatar,
                  height: 96,
                  width: 96,
                ),
                Image.asset(
                  AppImages.avatar,
                  height: 96,
                  width: 96,
                ),
                Image.asset(
                  AppImages.avatar,
                  height: 96,
                  width: 96,
                ),
                Image.asset(
                  AppImages.avatar,
                  height: 96,
                  width: 96,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
