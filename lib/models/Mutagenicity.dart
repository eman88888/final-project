import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:finalproject/pages/convert.dart';
import 'package:finalproject/pages/robot.dart';
import 'package:finalproject/result/mutagenicity_result.dart';
import 'package:finalproject/screens/bottomnavbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

//////////////

import 'package:http/http.dart' as http;
//////////////

class mutagenicity extends StatefulWidget {
  const mutagenicity({super.key});

  @override
  State<mutagenicity> createState() => _mutagenicityState();
}

class _mutagenicityState extends State<mutagenicity> {
  TextEditingController _smilesController = TextEditingController();
  String fileName = 'input.sdf';

//////////predict csv

  bool Resultrox = true;

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

////////////
  PlatformFile? selectedFile;
  bool resultsdf = true;
  void openfiles() async {
    FilePickerResult? resultfile = await FilePicker.platform.pickFiles();
    if (resultfile != null) {
      PlatformFile file = resultfile.files.first;
      print(file.name);

      if (kIsWeb) {
        // For web, use the bytes property instead of path
        Uint8List? bytes = file.bytes;
        if (bytes != null) {
          // Call uploadFile function with the selected file
          await uploadFile(file, bytes);
        } else {
          print('Failed to read file bytes');
        }
      } else {
        // For non-web platforms, use the path property
        String path = file.path!;
        print(path);

        // Call uploadFile function with the selected file
        await uploadFile(file, path);
      }
    } else {
      // Handle case when no file is selected
      print('No file selected');
    }
  }

  Future<void> uploadFile(PlatformFile file, dynamic fileContent) async {
    try {
      var url = Uri.parse(
          'http://localhost:5000//predictsdf'); // Replace with your server URL
      var request = http.MultipartRequest('POST', url);

      if (kIsWeb) {
        // For web, use the bytes property
        request.files.add(http.MultipartFile.fromBytes(
          'file',
          fileContent as List<int>,
          filename: file.name,
        ));
      } else {
        // For non-web, use the path
        String path = fileContent as String;
        List<int> bytes = File(path).readAsBytesSync();
        request.files.add(http.MultipartFile(
          'file',
          // Convert the bytes to a stream
          Stream.fromIterable(bytes.map((e) => [e])),
          bytes.length,
          filename: file.name,
        ));
      }

      var response = await request.send();
      if (response.statusCode == 200) {
        var responseData = await response.stream.bytesToString();
        var results = json.decode(responseData)['results'];

        // Convert the result to a boolean (true if result is 1, false if result is 0)
        bool resultBool = results == 1;

        // Save the result in the resultsdf variable
        setState(() {
          resultsdf = resultBool;
        });

        print('Results from server: $results');
        // Handle the results as needed
      } else {
        print('Failed to upload file: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception while uploading file: $e');
    }
  }

//////////
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
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 20, top: 30, bottom: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Input Smile",
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
                          "Or",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20, top: 30, bottom: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
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

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => mutresult(
                                    result: Resultrox,
                                    resultAtom: atoms,
                                    resulBond: resultsmile,
                                    resulImg: resultimg,
                                  ),
                                ),
                              );
                            }),
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
              FilePickerResult? result = await FilePicker.platform.pickFiles();

              if (result != null) {
                setState(() {
                  fileName = result.files.single.name;
                  selectedFile = result.files.single;
                });
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: Radius.circular(10),
                dashPattern: [10, 4],
                strokeCap: StrokeCap.round,
                color: Color(0xff1D5D9B),
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Color(0xfff8fafb),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
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
