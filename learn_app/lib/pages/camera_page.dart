import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  XFile? photo;

  Future<void> cropImage() async {
    if (photo?.path == null) {
      return;
    }
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: photo!.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );

    if (croppedFile?.path == null) {
      return;
    }
    setState(() {
      photo = XFile(croppedFile!.path);
    });
  }

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
            child: photo?.path == null
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
              icon: const Icon(Icons.image_search)),
          IconButton(
              onPressed: () {
                cropImage();
              },
              icon: const Icon(Icons.crop)),
        ],
      ),
    );
  }
}
