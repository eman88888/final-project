import 'dart:html';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:finalproject/models/Mutagenicity.dart';
import 'package:finalproject/models/Similarity_map.dart';
import 'package:finalproject/models/ToxicityofMolecules.dart';
import 'package:finalproject/models/liver_toxicity.dart';
import 'package:finalproject/screens/profile.dart';
import 'package:finalproject/screens/settings.dart';
import 'package:flutter/material.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _tocState();
}

class _tocState extends State<home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff1D5D9B),
        body: Column(
          children: [
            SizedBox(
              height: 100,
              width: 150,
              child: Image.asset(
                "assets/screen logo.png",
                fit: BoxFit.fill,
              ),
            ),
            Container(
              height: 755,
              width: 500,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Container(
                      width: 350,
                      height: 145,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Color(0xffF4D160),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 24, left: 5),
                            child: Column(
                              children: [
                                Text(
                                  "I am Mr.Tox,  ",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "I am here to help you",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  "any time.",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 120,
                            width: 110,
                            child: Image.asset("assets/Animation3.gif"),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ToxicityofMolecules_Screen()),
                            );
                          },
                          child: Container(
                            height: 210,
                            width: 178,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(25)),
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/image8.png",
                                  height: 135,
                                ),
                                Text(
                                  "Toxicity of molecules",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => mutagenicity()),
                            );
                          },
                          child: Container(
                            height: 210,
                            width: 178,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(25)),
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/image9.png",
                                  height: 135,
                                ),
                                Text(
                                  "Mutagenicity",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => liver()),
                            );
                          },
                          child: Container(
                            height: 210,
                            width: 178,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(25)),
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/image10.png",
                                  height: 135,
                                ),
                                Text(
                                  "Liver toxicity",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => similarity()),
                            );
                          },
                          child: Container(
                            height: 210,
                            width: 178,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(25)),
                            child: Column(
                              children: [
                                Image.asset(
                                  "assets/similarty.png",
                                  height: 135,
                                ),
                                Text(
                                  "Similarity map",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
