import 'dart:html';


import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:finalproject/cubit/convert_cubit.dart';
import 'package:finalproject/screens/bottomnavbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//////////////
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:html' as html;
// ignore: unused_shown_name
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;

//////////////
class convertScreen extends StatefulWidget {
  const convertScreen({super.key});
  @override
  State<convertScreen> createState() => _convertScreenState();
}

class _convertScreenState extends State<convertScreen> {
  final TextEditingController _smilesController = TextEditingController();
  final TextEditingController _smiles1Controller = TextEditingController();
  String fileName = 'input.sdf';
  //////////
  String sdf2dData = '';
  Future<void> convertAndDownload(String convert) async {
    const String apiUrl = 'http://127.0.0.1:5000/convert';
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'smiles': convert}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          sdf2dData = data['sdf2d'];
        });

        // Save the SDF2D data to a file using dart:html
        final blob = html.Blob([sdf2dData]);
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement(href: url)
          ..target = 'webSaveLink'
          ..download = 'molecule.sdf';
        html.document.body?.append(anchor);
        anchor.click();
        html.Url.revokeObjectUrl(url);
        sdf2dData = 'Molecule data saved successfully';

        //Showdialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Image.asset(
                'assets/success.png',
                height: 70,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Successfully Convert!",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'MulishRomanBold'),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Please check your downloads.",
                    style: TextStyle(fontSize: 17),
                  )
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "OK",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Image.asset(
                'assets/close.png',
                height: 70,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    " ${response.statusCode}",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'MulishRomanBold'),
                  ),
                  SizedBox(height: 15),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "OK",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Image.asset(
              'assets/close.png',
              height: 70,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$e",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'MulishRomanBold'),
                ),
                SizedBox(height: 15),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "OK",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }

//////////////////

  String pdbData = '';

  Future<void> convertAndDownloadpdb(String convert) async {
    const String apiUrl = 'http://127.0.0.1:5000/generate_pdb';
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'smiles': convert}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        pdbData = data['pdb'];
        setState(() {
          pdbData = data['pdb'];
        });

        // Save the SDF2D data to a file using dart:html
        final blob = html.Blob([pdbData]);
        final url = html.Url.createObjectUrlFromBlob(blob);
        final anchor = html.AnchorElement(href: url)
          ..target = 'webSaveLink'
          ..download = 'molecule.pdb';
        html.document.body?.append(anchor);
        anchor.click();
        html.Url.revokeObjectUrl(url);
        pdbData = 'Molecule data saved to molecule.pdb';

        //Showdialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Image.asset(
                'assets/success.png',
                height: 70,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Successfully Convert!",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'MulishRomanBold'),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Please check your downloads.",
                    style: TextStyle(fontSize: 17),
                  )
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "OK",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Image.asset(
                'assets/close.png',
                height: 70,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    " ${response.statusCode}",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'MulishRomanBold'),
                  ),
                  SizedBox(height: 15),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "OK",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Image.asset(
              'assets/close.png',
              height: 70,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$e",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'MulishRomanBold'),
                ),
                SizedBox(height: 15),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "OK",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  ///////
  PlatformFile? selectedFile;

  Future<void> uploadFile(BuildContext context) async {
    if (selectedFile == null) {
      // Handle case when no file is selected
      return;
    }

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://127.0.0.1:5000/converttosmile'), // Update URL accordingly
      );
      request.files.add(
        http.MultipartFile.fromBytes(
          'file',
          selectedFile!.bytes!,
          filename: selectedFile!.name,
        ),
      );

      var response = await request.send();

      if (response.statusCode == 200) {
        // For web, create a Blob URL and initiate download
        Uint8List content = await response.stream.toBytes();
        final blob = Blob([content]);
        final url = Url.createObjectUrlFromBlob(blob);
        AnchorElement(href: url)
          ..setAttribute("download", "smiles.smi")
          ..click();
        Url.revokeObjectUrl(url);
        //Showdialog
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Image.asset(
                'assets/success.png',
                height: 70,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Successfully Convert!",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'MulishRomanBold'),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Please check your downloads.",
                    style: TextStyle(fontSize: 17),
                  )
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "OK",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Image.asset(
                'assets/close.png',
                height: 70,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    " ${response.statusCode}",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'MulishRomanBold'),
                  ),
                  SizedBox(height: 15),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "OK",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Image.asset(
              'assets/close.png',
              height: 70,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$e",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'MulishRomanBold'),
                ),
                SizedBox(height: 15),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "OK",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    String fileName = 'input.sdf';
    return BlocProvider(
        create: (context) => ConvertCubit(),
        child: BlocConsumer<ConvertCubit, ConvertState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Scaffold(
                backgroundColor: Color(0xff1D5D9B),
                body: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(10),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BottomNavBar()),
                          );
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 45),
                      child: Container(
                          alignment: Alignment.center,
                          child: Image.asset(
                            "convertIcon.png",
                            width: 230,
                            height: 230,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.white,
                            isDismissible: false,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(25),
                                    topLeft: Radius.circular(25))),
                            builder: (context) => Container(
                              height: 563,
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 4.51,
                                      width: 134,
                                      color: Color(0xffCACACA),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 30, left: 40),
                                    child: Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Input Smile",
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w700),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 20, right: 20),
                                    child: TextFormField(
                                      ////
                                      keyboardType: TextInputType.multiline,
                                      textAlign: TextAlign.start,
                                      autofocus: false,
                                      style: new TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black),
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          borderSide: BorderSide(
                                            color: Color(0xff1D5D9B),
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          borderSide: BorderSide(
                                            color: Color(0xFF000000),
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFF000000),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(32.0)),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 60, horizontal: 10),
                                      ),
                                      controller: _smilesController,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 180),
                                    child: Container(
                                      // margin: const EdgeInsets.only(left:80,right: 80,bottom: 50,top: 50),
                                      height: 66,
                                      width: 285,
                                      child: MaterialButton(
                                        onPressed: () {
                                          setState(() {
                                            convertAndDownload(
                                                _smilesController.text);
                                          });
                                        },
                                        child: const Text(
                                          'Convert',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        color: const Color(0xff1D5D9B),
                                        textColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 322,
                          height: 64,
                          decoration: BoxDecoration(
                            color: Color(0xffFFFFFF),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Text(
                            "SMILE TO SDF",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.white,
                            isDismissible: false,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(25),
                                    topLeft: Radius.circular(25))),
                            builder: (context) => Container(
                              height: 563,
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 4.51,
                                      width: 134,
                                      color: Color(0xffCACACA),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 30, left: 40),
                                    child: Container(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          "Input Smile",
                                          style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.w700),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10, left: 20, right: 20),
                                    child: TextFormField(
                                      keyboardType: TextInputType.multiline,
                                      textAlign: TextAlign.start,
                                      autofocus: false,
                                      style: new TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black),
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          borderSide: BorderSide(
                                            color: Color(0xff1D5D9B),
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          borderSide: BorderSide(
                                            color: Color(0xFF000000),
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0xFF000000),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(32.0)),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 60, horizontal: 10),
                                      ),
                                      controller: _smiles1Controller,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 180),
                                    child: Container(
                                      // margin: const EdgeInsets.only(left:80,right: 80,bottom: 50,top: 50),
                                      height: 66,
                                      width: 285,
                                      child: MaterialButton(
                                        onPressed: () {
                                          setState(() {
                                            convertAndDownloadpdb(
                                                _smiles1Controller.text);
                                          });
                                        },
                                        child: const Text(
                                          'Convert',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        color: const Color(0xff1D5D9B),
                                        textColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 322,
                          height: 64,
                          decoration: BoxDecoration(
                            color: Color(0xffFFFFFF),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Text(
                            "SMILE TO PDB",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 60),
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.white,
                            isDismissible: false,
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(25),
                                    topLeft: Radius.circular(25))),
                            builder: (context) => Container(
                              height: 563,
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Container(
                                      alignment: Alignment.center,
                                      height: 4.51,
                                      width: 134,
                                      color: Color(0xffCACACA),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Center(
                                        child: GestureDetector(
                                            onTap: () async {
                                              FilePickerResult? result =
                                                  await FilePicker.platform
                                                      .pickFiles();

                                              if (result != null) {
                                                setState(() {
                                                  fileName =
                                                      result.files.single.name;
                                                  selectedFile =
                                                      result.files.single;
                                                });
                                              }
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 30, left: 10, right: 10),
                                              child: DottedBorder(
                                                borderType: BorderType.RRect,
                                                radius: Radius.circular(10),
                                                dashPattern: [10, 4],
                                                strokeCap: StrokeCap.round,
                                                color: Color(0xff1D5D9B),
                                                child: Container(
                                                  width: 298,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                    color: Color(0xfff8fafb),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Image.asset(
                                                        "uploud.png",
                                                        width: 115,
                                                        height: 76,
                                                      ),
                                                      Text(
                                                        "Upload SDF File",
                                                        style: TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ))),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 250),
                                    child: Container(
                                      // margin: const EdgeInsets.only(left:80,right: 80,bottom: 50,top: 50),
                                      height: 66,
                                      width: 285,
                                      child: MaterialButton(
                                        onPressed: () {
                                          setState(() {
                                            uploadFile(context);
                                          });
                                        },
                                        child: const Text(
                                          'Convert',
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        color: const Color(0xff1D5D9B),
                                        textColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 322,
                          height: 64,
                          decoration: BoxDecoration(
                            color: Color(0xffFFFFFF),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Text(
                            "SDF TO SMILE ",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }));
  }
}
