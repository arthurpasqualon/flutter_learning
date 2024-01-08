import 'package:flutter/material.dart';
import 'package:learn_app/shared/app_images.dart';

class ImageAssets extends StatefulWidget {
  const ImageAssets({super.key});

  @override
  State<ImageAssets> createState() => _ImageAssetsState();
}

class _ImageAssetsState extends State<ImageAssets> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          AppImages.avatar,
          height: 96,
          width: 96,
        ),
      ],
    );
  }
}
