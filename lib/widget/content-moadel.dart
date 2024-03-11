import 'package:flutter/material.dart';

class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent(
      {required this.image, required this.title, required this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: 'Toxicity of molecules',
      image: 'assets/image1.png',
      discription:
          "You can easily know toxicity of  a molecule using a smile or an image. "),
  UnbordingContent(
      title: 'Mutagenicity',
      image: 'assets/image2.png',
      discription:
          "You can easily know some molecule may make mutation or not.  "),
  UnbordingContent(
      title: 'Liver toxicity',
      image: 'assets/image3.png',
      discription:
          "You can easily know some molecule affects badly on liver or not.  "),
];
