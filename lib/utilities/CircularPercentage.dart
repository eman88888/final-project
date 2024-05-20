// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MolPercent extends StatefulWidget {
  const MolPercent(
      {super.key, required this.progressColor, required this.percent});

  // ignore: prefer_typing_uninitialized_variables
  final progressColor;
  final double percent;

  @override
  State<MolPercent> createState() => MolPercentState();
}

class MolPercentState extends State<MolPercent> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularPercentIndicator(
        radius: 80,
        lineWidth: 10,
        percent: widget.percent,
        backgroundColor: const Color.fromARGB(255, 223, 230, 241),
        progressColor: widget.progressColor,
        circularStrokeCap: CircularStrokeCap.round,
        center: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      offset: Offset(5, 5),
                      color: Color(0xFF9FB5D6),
                      blurRadius: 10,
                      spreadRadius: 1),
                ],
              ),
              child: Center(
                child: Text(
                  '${(widget.percent)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
