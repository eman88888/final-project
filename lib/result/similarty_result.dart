import 'dart:async';

import 'package:finalproject/pages/convert.dart';
import 'package:finalproject/pages/robot.dart';
import 'package:finalproject/screens/bottomnavbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'liver_result.dart';
//////////////
import 'dart:convert';
import 'package:http/http.dart' as http;

//////////////
class simresult extends StatefulWidget {
  const simresult({Key? key}) : super(key: key);

  @override
  State<simresult> createState() => _simresultState();
}

class _simresultState extends State<simresult>
    with SingleTickerProviderStateMixin {
  TextEditingController _smiles1Controller = TextEditingController();
  TextEditingController _smiles2Controller = TextEditingController();
  //////////
  bool Resultrox = true;
  bool Show = true;

  @override
  void dispose() {
    _smiles1Controller.dispose();
    _smiles2Controller.dispose();
    super.dispose();
  }

  Future<bool> fetchResultFromServer(String smiles1, String smiles2) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:5000/generate_similarity_map'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'smiles1': smiles1, 'smiles2': smiles2}),
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
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Container(
                          alignment: Alignment.topCenter,
                          child: const Text(
                            "Input two smiles to find similarity",
                            style: TextStyle(
                                color: Color(0xff1D5D9B),
                                fontSize: 20,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20, top: 30, bottom: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Smile 1",
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
                            controller: _smiles1Controller,
                            keyboardType: TextInputType.multiline,
                            decoration: const InputDecoration(
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
                        padding: EdgeInsets.only(left: 20, top: 30, bottom: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Smile 2",
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
                            controller: _smiles2Controller,
                            keyboardType: TextInputType.multiline,
                            decoration: const InputDecoration(
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
                        margin: const EdgeInsets.only(
                          top: 30,
                          bottom: 80,
                        ),
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
                            onPressed: () {
                              setState(() {
                                Show = false;
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
                                        width: screenSize.width,
                                        height: 432,
                                        child: Column(children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 270),
                                            child: MaterialButton(
                                              height: 24,
                                              minWidth: 24,
                                              onPressed: () async {
                                                setState(() {
                                                  Show = false;
                                                });
                                                String smiles1 =
                                                    _smiles1Controller.text;
                                                String smiles2 =
                                                    _smiles2Controller.text;
                                                await fetchResultFromServer(
                                                    smiles1, smiles2);
                                                setState(() {
                                                  Show = true;
                                                });
                                              },
                                              child: Container(
                                                color: Color(0xff1D5D9B),
                                                height: 24,
                                                width: 24,
                                                child: Icon(
                                                  Icons.clear_sharp,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Divider(),
                                        ]),
                                      ),
                                      insetPadding: const EdgeInsets.all(10),
                                    );
                                  },
                                );
                              });
                            }),
                      ),
                      Visibility(
                        visible: Show,
                        child: Container(
                          height: 179,
                          width: 179,
                          alignment: Alignment.center,
                          child: Image.asset(
                            'assets/Animation7.gif',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ],
        ));
  }
}
