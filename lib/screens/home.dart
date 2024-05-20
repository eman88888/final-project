import 'package:finalproject/models/Mutagenicity.dart';
import 'package:finalproject/models/Similarity_map.dart';
import 'package:finalproject/models/ToxicityofMolecules.dart';
import 'package:finalproject/models/liver_toxicity.dart';
import 'package:finalproject/pages/robot.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _tocState();
}

// ignore: camel_case_types
class _tocState extends State<home> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 200,
          color: const Color(0xff1D5D9B),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 35),
          child: Container(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: 80,
              width: 150,
              child: Image.asset(
                "assets/screen logo.png",
                fit: BoxFit.fill,
              ),
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
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Container(
                      width: 350,
                      height: 145,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: const Color(0xffF4D160),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 24, left: 5),
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
                          //to robot
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const robot()),
                              );
                            },
                            child: SizedBox(
                              height: 120,
                              width: 110,
                              child: Image.asset("assets/Animation3.gif"),
                            ),
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
                                      const ToxicityofMolecules_Screen()),
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
                                const Text(
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
                                  builder: (context) => const mutagenicity()),
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
                                const Text(
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
                              MaterialPageRoute(
                                  builder: (context) => const liver()),
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
                                const Text(
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
                                  builder: (context) => const similarity()),
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
                                const Text(
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
                  ),
                ],
              ),
            )),
      ],
    ));
  }
}
