import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/pages/convert.dart';
import 'package:finalproject/pages/robot.dart';
import 'package:finalproject/result/liver_result.dart';
import 'package:finalproject/screens/bottomnavbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

///////////
import 'dart:convert';
import 'package:http/http.dart' as http;

///////////

DateTime dateToday = DateTime.now();
String date = dateToday.toString().substring(0, 10);

class liver extends StatefulWidget {
  //const liver({Key? key}) : super(key: key);
  const liver({super.key});

  @override
  State<liver> createState() => _liverState();
}

class _liverState extends State<liver> {
  TextEditingController _smilesController = TextEditingController();

  @override
  void dispose() {
    _smilesController.dispose();
    super.dispose();
  }

/////////////predict liver
  bool Resultrox = true;

  Future<bool> fetchResultFromServer(String smiles) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:5000/predictliver'),
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

/////////////predict liver
  ///image
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

  ///image
/////////atom and bond
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

/////////////////////
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

/////
  CollectionReference history =
      FirebaseFirestore.instance.collection('history');
  Future<void> addHistory({
    required String smiles,
    required String resultText,
    required String date,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('history').add({
        'result': resultText,
        'input': smiles,
        'date': date,
        'category': 'Liver Toxicity',
        'id': FirebaseAuth.instance.currentUser!.uid,
      });
      print('History added successfully');
    } catch (e) {
      print('Failed to add history: $e');
    }
  }

////
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
                MaterialPageRoute(builder: (context) => const robot()),
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
            color: const Color(0xff1D5D9B),
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
                "Liver Toxicity",
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
                  Container(
                    padding:
                        const EdgeInsets.only(left: 30, top: 30, bottom: 10),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Input",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 4, right: 4, bottom: 10),
                    child: Container(
                      width: 326,
                      height: 65,
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
                              borderSide: BorderSide(color: Color(0xff717171))),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25)),
                              borderSide: BorderSide(color: Color(0xff717171))),
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

                          await processSmiles(smiles);
                          await fetch3DStructure(smiles);
                          await computeGasteigerCharges(smiles);
                          String resultText = result
                              ? 'positive'
                              : 'negative'; // Convert boolean result to text

                          await addHistory(
                            smiles: smiles,
                            resultText: resultText,
                            date: date,
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => livresult(
                                result: Resultrox,
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
                      child: Image.asset("assets/image14.png"),
                    ),
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
