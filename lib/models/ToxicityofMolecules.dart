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
//////predict toxcicty

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

//////predict toxcicty
/////sa,tox
  double _saScore = 0.0;
  double _toxicityScore = 0.0;

  Future<void> _predictMolecule() async {
    try {
      final String apiUrl = 'http://127.0.0.1:5000/predictmol';
      final String smiles = _smilesController.text;

      // Check if input is empty
      if (smiles.isEmpty) {
        setState(() {
          _toxicityScore = 0;
        });
        return;
      }
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'smiles': smiles}),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        if (result.containsKey('toxicity_score')) {
          final toxicityScore = result['toxicity_score'];
          setState(() {
            _toxicityScore = double.parse(toxicityScore.toString());
            print('Toxicity Score: $_toxicityScore');
          });
        } else {
          print('Failed to predict toxicity: Invalid response format');
        }
      } else {
        print('Failed to predict toxicity: ${response.statusCode}');
      }
    } catch (e) {
      print('Error predicting toxicity: $e');
    }
  }

  Future<void> _calculateSaScore() async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000/calculate_sa_score'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'smiles': _smilesController.text}),
    );

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      if (result['success']) {
        final saScoreNormalized = result['sa_score_normalized'];
        if (saScoreNormalized != null) {
          setState(() {
            _saScore = double.parse(saScoreNormalized.toString());
            print('SA Score: $_saScore');
          });
        } else {
          print('SA score is null');
        }
      } else {
        print('Failed to calculate SA score: ${result['error']}');
      }
    } else {
      print('Failed to calculate SA score: ${response.statusCode}');
    }
  }

/////sa,tox
////////atom and bond
  String resultsmile = '';
  String atoms = '';

  Future<void> processSmiles(String liver) async {
    String url =
        'http://localhost:5000/process_smiles'; // Update with your server URL

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'smiles': liver}),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        resultsmile = '${data['bonds']}';
        atoms = '${data['atoms']}';
      } else {
        resultsmile = response.statusCode.toString();
      }
    } catch (e) {
      print(e);
    }
  }

////////////////
  String resultimg = '';

  Future<void> fetch3DStructure(String smiles) async {
    var url = Uri.parse('http://localhost:5000/generate_3d_structure');
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'smiles': smiles}),
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      String imgStr = jsonResponse['image_data'];
      // Save the image data to the resultimg variable or use it as needed
      setState(() {
        resultimg = imgStr;
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

////////////////////
  String gester = ''; // Variable to store the result

  Future<void> computeGasteigerCharges(String smiles) async {
    var url = Uri.parse('http://localhost:5000/compute_gasteiger_charges');
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'smiles': smiles}),
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var result = jsonResponse['result'];
      setState(() {
        gester = result;
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
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
                        padding: EdgeInsets.only(left: 30, top: 30, bottom: 10),
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
                          height: 50,
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
                              await _calculateSaScore();
                              await _predictMolecule();
                              await processSmiles(smiles);
                              await fetch3DStructure(smiles);
                              await computeGasteigerCharges(smiles);

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ToxResult_Screen(
                                    result: Resultrox,
                                    resultsa: _saScore,
                                    resulttox: _toxicityScore,
                                    resultAtom: atoms,
                                    resulBond: resultsmile,
                                    Resulimg: resultimg,
                                    resulgester: gester,
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
