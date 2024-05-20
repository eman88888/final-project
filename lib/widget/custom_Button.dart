// ignore_for_file: file_names

import 'package:flutter/material.dart';

// ignore: camel_case_types
class customButton extends StatelessWidget {
  const customButton({super.key, required this.text});

  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xFFF1CF5F),
      ),
      width: 348,
      height: 60,
      child: Center(
        child: Text(
          text,
          style: const TextStyle(fontSize: 25, fontFamily: 'MulishRomanBold',fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
