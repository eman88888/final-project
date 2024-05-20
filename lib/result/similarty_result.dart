import 'dart:async';

import 'package:finalproject/pages/convert.dart';
import 'package:finalproject/pages/robot.dart';
import 'package:finalproject/screens/bottomnavbar.dart';
import 'package:flutter/material.dart';

//////////////
import 'dart:convert';
import 'package:http/http.dart' as http;

//////////////
// ignore: camel_case_types
class simresult extends StatefulWidget {
  const simresult({Key? key}) : super(key: key);

  @override
  State<simresult> createState() => _simresultState();
}

// ignore: camel_case_types
class _simresultState extends State<simresult>
    with SingleTickerProviderStateMixin {
  final TextEditingController _smiles1Controller = TextEditingController();
  final TextEditingController _smiles2Controller = TextEditingController();
  // ignore: non_constant_identifier_names
  bool Show = true;

////////////map
  Future<String> generateSimilarityMap(
      String molSmiles, String refMolSmiles) async {
    try {
      var url = Uri.parse('http://localhost:5000/generate_similarity_map');
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json', // Set content type here
        },
        body: jsonEncode({
          'mol_smiles': molSmiles,
          'refmol_smiles': refMolSmiles,
        }),
      );

      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        if (responseData['success']) {
          return responseData['image_base64'];
        } else {
          // ignore: avoid_print
          print('API request failed: ${responseData['error']}');
        }
      } else {
        // ignore: avoid_print
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Exception: $e');
    }
    return ''; // Return an empty string if there's an error
  }

///////////////
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
                    MaterialPageRoute(builder: (context) => const BottomNavBar()),
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
                        padding: const EdgeInsets.only(
                            left: 30, top: 30, bottom: 10),
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          "Smile 1",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 4, right: 4, bottom: 10),
                        // ignore: sized_box_for_whitespace
                        child: Container(
                          //change
                          width: 326,
                          height: 55,
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
                        padding: const EdgeInsets.only(
                            left: 30, top: 30, bottom: 10),
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          "Smile 2",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 4, right: 4, bottom: 10),
                        // ignore: sized_box_for_whitespace
                        child: Container(
                          width: 326,
                          height: 55,
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
                          color: const Color(0xffF4D160),
                          textColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          onPressed: () async {
                            setState(() {
                              Show = false;
                            });

                            String imageBytes = await generateSimilarityMap(
                                _smiles1Controller.text,
                                _smiles2Controller.text);

                            showDialog(
                              // ignore: use_build_context_synchronously
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
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 270),
                                          child: MaterialButton(
                                            height: 24,
                                            minWidth: 24,
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); // Close the AlertDialog
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

                                        Image.memory(base64Decode(
                                            imageBytes)), // Display the image
                                      ],
                                    ),
                                  ),
                                  insetPadding: const EdgeInsets.all(10),
                                );
                              },
                            );
                          },
                          child: const Text(
                            'Submit',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
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
