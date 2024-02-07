import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  XFile? photo;

  Future<void> openCamera() async {
    final ImagePicker picker = ImagePicker();
    picker.pickImage(source: ImageSource.camera).then((XFile? value) {
      setState(() {
        photo = value;
      });
    });
  }

  Future<void> openGallery() async {
    final ImagePicker picker = ImagePicker();
    picker.pickImage(source: ImageSource.gallery).then((XFile? value) {
      setState(() {
        photo = value;
      });
    });
  }

  @override
  void initState() {
    openCamera();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Camera Page"),
      ),
      body: Column(
        children: [
          const Text("Camera Page"),
          SizedBox(
            height: 200,
            child: photo == null
                ? const Center(child: CircularProgressIndicator())
                : Image.file(
                    File(photo!.path),
                    fit: BoxFit.cover,
                  ),
          ),
          IconButton(
              onPressed: () {
                openCamera();
              },
              icon: const Icon(Icons.camera_alt_rounded)),
          IconButton(
              onPressed: () {
                openGallery();
              },
              icon: const Icon(Icons.image_search))
        ],
      ),
    );
  }
}
