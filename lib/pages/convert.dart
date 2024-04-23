import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:finalproject/cubit/convert_cubit.dart';
import 'package:finalproject/screens/bottomnavbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//////////////
import 'dart:convert';
import 'package:http/http.dart' as http;

//////////////
class convertScreen extends StatefulWidget {
  const convertScreen({super.key});
  @override
  State<convertScreen> createState() => _convertScreenState();
}

class _convertScreenState extends State<convertScreen> {
  final TextEditingController _smilesController = TextEditingController();
  //////////
  bool Resultrox = true;
  Future<bool> fetchResultFromServersmiletosdf(String smiles) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:5000/convert'),
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

//////////////////
  Future<bool> fetchResultFromServersmiletopdb(String smiles) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:5000/generate_pdb'),
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
/////////////////

  Future<bool> fetchResultFromServersdftosmile(String smiles) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:5000/converttosmile'),
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

  ///////
  @override
  Widget build(BuildContext context) {
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
                                            ConvertCubit.get(context)
                                                .convertAndDownload(
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
                                            ConvertCubit.get(context)
                                                .convertAndDownload(
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
                                                  ConvertCubit.get(context)
                                                          .selectedFile =
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
                                            ConvertCubit.get(context)
                                                .uploadFile(context);
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
