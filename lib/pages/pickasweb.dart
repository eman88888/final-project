import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class pick_img extends StatefulWidget {
  const pick_img({super.key});

  @override
  State<pick_img> createState() => _pick_imgState();
}

// ignore: camel_case_types
class _pick_imgState extends State<pick_img> {
  // ignore: unused_field
  Uint8List? _image;
  File? selectedIMage;
  String? url;
  Uint8List imageBytes = Uint8List(0);
  Future<void> pickImageFromGallery(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.image,
      );
      if (result != null && result.files.isNotEmpty) {
        setState(() {
          imageBytes = result.files.single.bytes ?? Uint8List(0);
        });
      }
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } catch (e) {
      // ignore: avoid_print
      print('Error picking image: $e');
    }
  }

  Future<String?> uploadImageToFirebase() async {
    if (imageBytes.isEmpty) {
      // ignore: avoid_print
      print('No image selected.');
      return null;
    }

    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        // ignore: avoid_print
        print('User not signed in.');
        return null;
      }

      final storageRef = FirebaseStorage.instance.ref().child(
          "user_images/${currentUser.uid}/${DateTime.now().toIso8601String()}.jpg");

      await storageRef.putData(imageBytes);

      final imageUrl = await storageRef.getDownloadURL();

      setState(() {
        url = imageUrl;
      });

      // ignore: avoid_print
      print('File uploaded successfully. Image URL: $imageUrl');
      return imageUrl;
    } catch (e) {
      // ignore: avoid_print
      print('Error uploading file: $e');

      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
