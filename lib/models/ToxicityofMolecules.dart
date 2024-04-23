import 'package:finalproject/pages/convert.dart';
import 'package:finalproject/pages/robot.dart';
import 'package:finalproject/screens/bottomnavbar.dart';
import 'package:flutter/material.dart';

import '../result/ToxResultScreen.dart';

//////////////
import 'dart:convert';
import 'package:http/http.dart' as http;

//////////////
class ToxicityofMolecules_Screen extends StatefulWidget {
  const ToxicityofMolecules_Screen({super.key});

  @override
  State<ToxicityofMolecules_Screen> createState() =>
      _ToxicityofMolecules_ScreenState();
}

class _ToxicityofMolecules_ScreenState
    extends State<ToxicityofMolecules_Screen> {
  TextEditingController _smilesController = TextEditingController();

  @override
  void dispose() {
    _smilesController.dispose();
    super.dispose();
  }

  bool Resultrox = true;

  Future<bool> fetchResultFromServer(String smiles) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:5000/predicttoxcity'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'smiles': smiles}),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        bool result = data['prediction'] == 1;
        setState(() {
          Resultrox = result;
        });
        return result;
      } else {
        throw Exception('Failed to fetch result: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching result: $e');
      throw Exception('Failed to fetch result');
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BottomNavBar()),
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
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 200,
              color: Color(0xff1D5D9B),
            ),
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
            Container(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => convertScreen()),
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
                  "Toxicity of molecules",
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
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 20, top: 30, bottom: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Input",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 4, right: 4, bottom: 10),
                        child: Container(
                          width: 326,
                          height: 38.44,
                          child: TextFormField(
                            controller: _smilesController,
                            keyboardType: TextInputType.multiline,
                            decoration: const InputDecoration(
                              hintText: "Smile",
                              hintStyle: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                              fillColor: Color(0xfffefcfc),
                              filled: true,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                  borderSide:
                                      BorderSide(color: Color(0xff717171))),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
                                  borderSide:
                                      BorderSide(color: Color(0xff717171))),
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 30, bottom: 30),
                        height: 60,
                        width: 300,
                        child: MaterialButton(
                            child: const Text(
                              'Submit',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            color: const Color(0xffF4D160),
                            textColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            onPressed: () async {
                              String smiles = _smilesController.text;
                              bool result = await fetchResultFromServer(smiles);

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ToxResult_Screen(
                                    result: Resultrox,
                                  ),
                                ),
                              );
                            }),
                      ),
                      Container(
                          child: Padding(
                        padding: const EdgeInsets.only(top: 80),
                        child: Container(
                          width: 370,
                          child:
                              Image.asset("assets/Toxicity of Molecules.png"),
                        ),
                      )),
                    ],
                  ),
                )),
          ],
        ));
  }
}
