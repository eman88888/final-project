import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';

class customButton extends StatelessWidget {
  customButton({required this.text});

  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Color(0xFFF1CF5F),
      ),
      width: 348,
      height: 60,
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 25, fontFamily: 'MulishRomanBold',fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
