// ignore_for_file: file_names

import 'dart:convert';

import 'package:finalproject/pages/convert.dart';
import 'package:finalproject/pages/robot.dart';
import 'package:finalproject/screens/bottomnavbar.dart';
import 'package:finalproject/widget/result_contanier.dart';
import 'package:flutter/material.dart';

import '../models/ToxicityofMolecules.dart';

import '../utilities/CircularPercentage.dart';

// ignore: camel_case_types
class ToxResult_Screen extends StatefulWidget {
  final bool result;
  final double resulttox;
  final double resultsa;
  final String resultAtom;
  final String resulBond;
  // ignore: non_constant_identifier_names
  final String Resulimg;
  final String resulgester;

  const ToxResult_Screen(
      {Key? key,
      required this.result,
      required this.resulttox,
      required this.resultsa,
      required this.resultAtom,
      required this.resulBond,
      // ignore: non_constant_identifier_names
      required this.Resulimg,
      required this.resulgester})
      : super(key: key);

  @override
  State<ToxResult_Screen> createState() => _ToxResult_ScreenState();
}

// ignore: camel_case_types
class _ToxResult_ScreenState extends State<ToxResult_Screen> {
  bool textcolor = true;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // ignore: avoid_unnecessary_containers
          Container(
            child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const BottomNavBar()),
                    );
                  },
                  child: Image.asset(
                    "assets/home icon.png",
                    height: 35,
                  ),
                )),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const robot()),
              );
            },
            // ignore: avoid_unnecessary_containers
            child: Container(
              child: Image.asset(
                "assets/Animation3.gif",
                height: 60,
                width: 65,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 200,
            color: const Color(0xff1D5D9B),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ToxicityofMolecules_Screen()),
                );
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            alignment: Alignment.topRight,
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const convertScreen()),
                );
              },
              icon: Image.asset(
                "convert.png",
                height: 30,
                width: 35,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 35),
            child: Container(
              alignment: Alignment.topCenter,
              child: const Text(
                "Result",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
          Positioned(
            top: 100,
            child: Container(
              width: screenSize.width,
              height: screenSize.height,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 50),
                        child: resultwidgetcontainer(
                          result: widget.result,
                          text: "Toxic",
                          textcolor: textcolor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20, top: 50),
                        child: resultwidgetcontainer(
                          result: !widget.result,
                          text: "Non-Toxic",
                          textcolor: !textcolor,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40, bottom: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            MolPercent(
                              progressColor: const Color(0xFF191D88),
                              percent: widget.resulttox,
                            ),
                            const Text(
                              'Tox Score',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            MolPercent(
                              progressColor: Colors.red,
                              percent: widget.resultsa,
                            ),
                            const Text(
                              'SA Score',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Container(
                      alignment: Alignment.topRight,
                      height: 300,
                      width: 300,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: const Color(0xffCACACA), width: 1),
                          boxShadow: const [
                            BoxShadow(
                                color: Color(0xffCACACA),
                                offset: Offset(8, 8),
                                blurRadius: 4,
                                spreadRadius: 0)
                          ]),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: widget.Resulimg.isNotEmpty
                                  ? Image.memory(
                                      base64Decode(widget.Resulimg),
                                      width: 200,
                                      height: 200,
                                    )
                                  : Container(),
                            ),
                          ),
                          Positioned(
                            right: 0,
                            child: InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      backgroundColor: const Color(0xffFFFFFF),
                                      content: Container(
                                        alignment: Alignment.topLeft,
                                        height: 432,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 300),
                                                child: MaterialButton(
                                                  height: 24,
                                                  minWidth: 24,
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Container(
                                                    color: Colors.red,
                                                    height: 24,
                                                    width: 24,
                                                    child: const Icon(
                                                      Icons.clear_sharp,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const Divider(),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10, left: 30),
                                                // ignore: sized_box_for_whitespace
                                                child: Container(
                                                  height: 61,
                                                  width: 61,
                                                  child: Image.asset(
                                                    "assets/image12.png",
                                                    height: 61,
                                                    width: 61,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  // ignore: sized_box_for_whitespace
                                                  Container(
                                                    height: 24,
                                                    width: 27,
                                                    child: Image.asset(
                                                      "assets/image11.png",
                                                      height: 24,
                                                      width: 27,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child:
                                                        SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: Row(
                                                        children: [
                                                          const Text(
                                                            "Atomic Number:   ",
                                                            style: TextStyle(
                                                              color: Colors.red,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 20,
                                                            ),
                                                          ),
                                                          Text(
                                                            widget.resultAtom,
                                                            style:
                                                                const TextStyle(
                                                              color: Color(
                                                                  0xff1D5D9B),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 50),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  // ignore: sized_box_for_whitespace
                                                  Container(
                                                    height: 24,
                                                    width: 27,
                                                    child: Image.asset(
                                                      "assets/image11.png",
                                                      height: 24,
                                                      width: 27,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child:
                                                        SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: Row(
                                                        children: [
                                                          const Text(
                                                            "Gasteiger Charge:   ",
                                                            style: TextStyle(
                                                              color: Colors.red,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 20,
                                                            ),
                                                          ),
                                                          Text(
                                                            widget.resulgester,
                                                            style:
                                                                const TextStyle(
                                                              color: Color(
                                                                  0xff1D5D9B),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 50),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  // ignore: sized_box_for_whitespace
                                                  Container(
                                                    height: 24,
                                                    width: 27,
                                                    child: Image.asset(
                                                      "assets/image11.png",
                                                      height: 24,
                                                      width: 27,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child:
                                                        SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: Row(
                                                        children: [
                                                          const Text(
                                                            "Bonds Types:   ",
                                                            style: TextStyle(
                                                              color: Colors.red,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 20,
                                                            ),
                                                          ),
                                                          Text(
                                                            widget.resulBond,
                                                            style:
                                                                const TextStyle(
                                                              color: Color(
                                                                  0xff1D5D9B),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      insetPadding: const EdgeInsets.all(10),
                                    );
                                  },
                                );
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 8, right: 8),
                                // ignore: sized_box_for_whitespace
                                child: Container(
                                  height: 34,
                                  width: 48,
                                  child: Image.asset(
                                    "assets/info.png",
                                    height: 34,
                                    width: 48,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
