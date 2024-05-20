import 'package:flutter/material.dart';

// ignore: camel_case_types
class resultwidgetcontainer extends StatelessWidget {
  const resultwidgetcontainer({
    super.key,
    required this.result,
    required this.text,
    required this.textcolor,
  });

  final bool result;
  final String text;
  final bool textcolor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 173,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xff1D5D9B), width: 2),
        color: result ? const Color(0xff1D5D9B) : Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(text,
            style: TextStyle(
                color:
                    result ? const Color(0xffffffff) : const Color(0xff000000),
                fontWeight: FontWeight.w500,
                fontSize: 20)),
      ),
    );
  }
}
