import 'package:flutter/material.dart';

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
            color:
                isDark ? Color(0xff1D5D9B)
                       : Color.fromARGB(222, 164, 215, 244),
            width: 2),
            
        color: result
            ? isDark
                ? Color(0xff5C8AB7)
                : Color.fromARGB(222, 164, 215, 244)
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
                        : Color(0xff000000)
                    : isDark
                        ? Colors.black
                        : Color(0xff000000),
                fontWeight: FontWeight.w500,
                fontSize: 25)),
      ),
    );
  }
}
