import 'package:finalproject/pages/robot.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../screens/bottomnavbar.dart';

class info extends StatefulWidget {
  const info({Key? key}) : super(key: key);

  @override
  State<info> createState() => _infoState();
}

class _infoState extends State<info> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 200,
            color: Color(0xff1D5D9B),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(5.5),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BottomNavBar()),
                    );
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 70,
            child: Container(
              width: screenSize.width,
              height: screenSize.height,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  )),
              child: ListView(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 125, top: 20, bottom: 5),
                        child: Text(
                          'Information',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              fontFamily: 'MulishRomanBold'),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 70, top: 20, bottom: 5),
                        child: SvgPicture.asset(
                          'assets/information.svg',
                          height: 25,
                        ),
                      ),
                    ],
                  ),
                  Center(
                      child: Text('Common Questions',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15))),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 30),
                    child: Text(
                      "1. How can users utilize the program to research drug toxicity ?",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      " Users can input drug information via SMILES or images to investigate its toxicity.",
                      style: TextStyle(
                        color: Color(0xff6e6d6d),
                      ),
                    ),
                  ),
                  Divider(
                    color: Color(0xff6e6d6d),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      "2. How are the toxicity results presented to users, and what specific information do they receive?",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      "  Results are displayed, indicating whether the drug is toxic or non-toxic, along with SA Score and Tox Score.",
                      style: TextStyle(
                        color: Color(0xff6e6d6d),
                      ),
                    ),
                  ),
                  Divider(
                    color: Color(0xff6e6d6d),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      "3. How does the program handle the Mutagenicity analysis, and what are the expected results?",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      " The Mutagenicity analysis processes SMILES input and provides information on whether the substance is mutagenic or not.",
                      style: TextStyle(
                        color: Color(0xff6e6d6d),
                      ),
                    ),
                  ),
                  Divider(
                    color: Color(0xff6e6d6d),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      "4. Is Toxikon available to the general public, or is it targeted towards a specific group of researchers or specialists?",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      " Toxikon is accessible to both the general public and specific groups of researchers or specialists.",
                      style: TextStyle(
                        color: Color(0xff6e6d6d),
                      ),
                    ),
                  ),
                  Divider(
                    color: Color(0xff6e6d6d),
                  ),
                  Padding(padding: EdgeInsets.all(5)),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      "5. What is the significance and usage of SA Score and Tox Score in the program's results?",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      " SA Score and Tox Score provide insights into the drug's safety ,helping users interpret drug potential toxicity and its probability to be synthesized",
                      style: TextStyle(
                        color: Color(0xff6e6d6d),
                      ),
                    ),
                  ),
               
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => BottomNavBar()),
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
                              MaterialPageRoute(builder: (context) => robot()),
                            );
                          },
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
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
