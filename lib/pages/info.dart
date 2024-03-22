import 'dart:html';

import 'package:finalproject/screens/home.dart';
import 'package:finalproject/screens/settings.dart';
import 'package:flutter/material.dart';
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
    return Scaffold(
      backgroundColor: Color(0xff1D5D9B),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
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
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: const Icon(
                    Icons.info,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(2),
            child: Container(
              child: Text(
                'information',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Container(
              height: 788,
              width: 500,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.all(20)),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      "1. How can users utilize the program to research drug toxicity ?",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
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
                  Padding(padding: EdgeInsets.all(10)),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      "2. How are the toxicity results presented to users, and what specific information do they receive?",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
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
                  Padding(padding: EdgeInsets.all(10)),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      "3. How does the program handle the Mutagenicity analysis, and what are the expected results?",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
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
                  Padding(padding: EdgeInsets.all(10)),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      "4. Is Toxikon available to the general public, or is it targeted towards a specific group of researchers or specialists?",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
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
                  Padding(padding: EdgeInsets.all(10)),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      "5. What is the significance and usage of SA Score and Tox Score in the program's results?",
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      " SA Score and Tox Score provide insights into the drug's safety ,helping users interpret drug potential toxicity and its probability to be synthesized",
                      style: TextStyle(
                        color: Color(0xff6e6d6d),
                      ),
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
