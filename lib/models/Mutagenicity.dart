// ignore_for_file: file_names

import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:finalproject/pages/convert.dart';
import 'package:finalproject/pages/robot.dart';
import 'package:finalproject/result/mutagenicity_result.dart';
import 'package:finalproject/screens/bottomnavbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//////////////

import 'package:http/http.dart' as http;

//////////////
DateTime dateToday = DateTime.now();
String date = dateToday.toString().substring(0, 10);

// ignore: camel_case_types
class mutagenicity extends StatefulWidget {
  const mutagenicity({super.key});

  @override
  State<mutagenicity> createState() => _mutagenicityState();
}

// ignore: camel_case_types
class _mutagenicityState extends State<mutagenicity> {
  // ignore: prefer_final_fields
  TextEditingController _smilesController = TextEditingController();
  String fileName = 'input.sdf';

//////////predict csv//////////////////

  bool serverResult = true;

  Future<bool> fetchResultFromServer(String smiles) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:5000/predictcsv'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'smiles': smiles}),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        bool result = data['prediction'] == 1;
        setState(() {
          serverResult = result;
        });
        return result;
      } else {
        throw Exception('Failed to fetch result: ${response.statusCode}');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error fetching result: $e');
      throw Exception('Failed to fetch result');
    }
  }

//////////////////////atom and bond////////////////////////
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
      // ignore: avoid_print
      print(e);
    }
  }

//////////////////////image////////////////////////////////
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
      // ignore: avoid_print
      print('Request failed with status: ${response.statusCode}.');
    }
  }

////////////predictsdfmutagenicity/////////////////////////
  Future<void> uploadFile(List<int> fileBytes) async {
    try {
      var url = Uri.parse('http://localhost:5000/predictsdf');
      var request = http.MultipartRequest('POST', url);

      if (kIsWeb) {
        request.files.add(http.MultipartFile.fromBytes(
          'file',
          fileBytes,
          filename: fileName,
        ));
      } else {
        String path = fileBytes as String;
        List<int> bytes = File(path).readAsBytesSync();
        request.files.add(http.MultipartFile(
          'file',
          Stream.fromIterable(bytes.map((e) => [e])),
          bytes.length,
          filename: fileName,
        ));
      }

      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var results = json.decode(responseData)['results'];
        // Assuming results are integers (0 or 1), convert to bool
        serverResult = (results as List)
            .map((e) => e == 1)
            .toList()
            .first; // Convert 1 to true, 0 to false
        setState(() {
          // Set state or handle the result as needed
        });
        // ignore: avoid_print
        print('Results from server: $serverResult');
      } else {
        // ignore: avoid_print
        print('Failed to upload file: ${response.statusCode}');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Exception while uploading file: $e');
    }
  }

////////////////////////////////////////////////////////convert sdf

  String resultSmi = "";
  Future<void> convertSdfToSmiles(List<int> file) async {
    try {
      var url =
          'http://localhost:5000/converttosmile2'; // Update with your server URL
      var request = http.MultipartRequest('POST', Uri.parse(url));

      if (file is Uint8List) {
        request.files.add(
            http.MultipartFile.fromBytes('file', file, filename: 'temp.sdf'));
      } else if (file is String) {
        request.files
            .add(await http.MultipartFile.fromPath('file', file as String));
      }

      var response = await request.send();

      if (response.statusCode == 200) {
        String smile = await response.stream.bytesToString();
        // ignore: avoid_print
        print('Converted SMILES: $smile');
        setState(() {
          resultSmi = smile; // Assuming resultSmiles is a state variable
        });
      } else {
        // ignore: avoid_print
        print('Failed to convert SDF to SMILES: ${response.reasonPhrase}');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error converting SDF to SMILES: $e');
    }
  }

//////////////////////pick file //////////////////////
  Future<void> handleFileUpload() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['sdf'],
      );
      if (result != null) {
        List<int> fileBytes = result.files.single.bytes!;
        await uploadFile(fileBytes);
        await convertSdfToSmiles(fileBytes);

        // ignore: avoid_print
        print('Mutagenicity Prediction: $serverResult');
        // ignore: avoid_print
        print('SMILES Conversion: $resultSmi');
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error picking file: $e');
    }
  }

///////////////////
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
      // ignore: avoid_print
      print('Request failed with status: ${response.statusCode}.');
    }
  }

//////////////////
  CollectionReference history =
      FirebaseFirestore.instance.collection('history');
  Future<void> addHistory({
    required String smiles,
    required String serverResult,
    required String date,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('history').add({
        'result': serverResult,
        'input': smiles,
        'date': date,
        'category': 'Mutagenicity',
        'id': FirebaseAuth.instance.currentUser!.uid,
      });
      // ignore: avoid_print
      print('History added successfully');
    } catch (e) {
      // ignore: avoid_print
      print('Failed to add history: $e');
    }
  }

////////////////
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
                    MaterialPageRoute(builder: (context) => const convertScreen()),
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
                  "Mutagenicity",
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
                        padding: const EdgeInsets.only(left: 30, top: 30, bottom: 10),
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          "Input Smile",
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
                          height: 65,
                          child: TextFormField(
                            controller: _smilesController,
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
                        padding: const EdgeInsets.only(left: 20, top: 30, bottom: 10),
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          "Or",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20, top: 30, bottom: 10),
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          "Upload SDF ",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w700),
                        ),
                      ),
                      content(),
                      Container(
                        margin: const EdgeInsets.only(top: 100, bottom: 30),
                        height: 60,
                        width: 300,
                        child: MaterialButton(
                            color: const Color(0xffF4D160),
                            textColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            onPressed: () async {
                              if (_smilesController.text.isNotEmpty) {
                                String smiles = _smilesController.text;
                                // ignore: unused_local_variable
                                bool result =
                                    await fetchResultFromServer(smiles);
                                await processSmiles(smiles);
                                await fetch3DStructure(smiles);
                                await computeGasteigerCharges(smiles);
                                String resultText = serverResult
                                    ? 'mutagenic'
                                    : 'non-mutagenic'; // Convert boolean serverResult to text
                                await addHistory(
                                  smiles: smiles,
                                  serverResult: resultText,
                                  date: date,
                                );
                              } else {
                                await processSmiles(resultSmi);
                                await fetch3DStructure(resultSmi);
                                await computeGasteigerCharges(resultSmi);
                                String resultText = serverResult
                                    ? 'mutagenic'
                                    : 'non-mutagenic'; // Convert boolean serverResult to text
                                await addHistory(
                                  smiles: resultSmi,
                                  serverResult: resultText,
                                  date: date,
                                );
                              }

                              Navigator.push(
                                // ignore: use_build_context_synchronously
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MutResult(
                                    result: serverResult,
                                    resultAtom: atoms,
                                    resulBond: resultsmile,
                                    resulImg: resultimg,
                                    resulgester: gester,
                                  ),
                                ),
                              );
                            },
                            child: const Text(
                              'Submit',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                      ),
                    ],
                  ),
                )),
          ],
        ));
  }

  Widget content() {
    return Center(
        child: GestureDetector(
            onTap: () async {
              handleFileUpload();
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: const Radius.circular(10),
                dashPattern: const [10, 4],
                strokeCap: StrokeCap.round,
                color: const Color(0xff1D5D9B),
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    color: const Color(0xfff8fafb),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cloud_upload,
                        color: Color(0xff1D5D9B),
                        size: 80,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Upload Your File",
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }
}
