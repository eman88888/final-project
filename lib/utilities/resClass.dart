
// ignore_for_file: file_names

import 'package:flutter/material.dart';

// ignore: camel_case_types
class resultwidgetcontainer extends StatelessWidget {
  const resultwidgetcontainer({
    super.key,
    required this.isDark,
    required this.result,
    required this.text,
    required this.textcolor,
  });

  final bool isDark;
  final bool result;
  final String text;
  final bool textcolor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 173,
      decoration: BoxDecoration(
        border: Border.all(
            color: isDark
                ? const Color(0xff1D5D9B)
                : const Color.fromARGB(222, 164, 215, 244),
            width: 2),
        color: result
            ? isDark
                ? const Color(0xff5C8AB7)
                : const Color.fromARGB(222, 164, 215, 244)
            : isDark
                ? Colors.transparent.withOpacity(0)
                : Colors.white,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Center(
        child: Text(text,
            style: TextStyle(
                color: textcolor
                    ? isDark
                        ? Colors.white
                        : const Color(0xff000000)
                    : isDark
                        ? Colors.black
                        : const Color(0xff000000),
                fontWeight: FontWeight.w500,
                fontSize: 25)),
      ),
    );
  }
}
