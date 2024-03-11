import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:finalproject/screens/bottomnavbar.dart';
import 'package:finalproject/screens/settings.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../widget/custom_TextFormField.dart';

class EditProfile_Page extends StatefulWidget {
  EditProfile_Page({super.key});

  @override
  State<EditProfile_Page> createState() => _PickImageState();
}

class _PickImageState extends State<EditProfile_Page> {
  /////////UserName
  String _userName = '';
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _JobController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();

  ////////For image
  Uint8List? _image;
  File? selectedIMage;
  File? file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1D5D9B),
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 35, right: 350),
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

            Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 90, backgroundImage: MemoryImage(_image!))
                    : const CircleAvatar(
                        radius: 90,
                        backgroundImage:
                            AssetImage("assets/images/Profile.png"),
                      ),
                Positioned(
                    bottom: -0,
                    left: 140,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.blue, // Border color
                          width: 2.0, // Border width
                        ),
                        borderRadius:
                            BorderRadius.circular(30), // Border radius
                      ),
                      child: IconButton(
                          color: Color(0xFF1D5D9B),
                          iconSize: 20,
                          onPressed: () {
                            showImagePickerOption(context);
                          },
                          icon: const Icon(
                            Icons.add_a_photo,
                          )),
                    ))
              ],
            ),
            /////// Display the user's name below the input field
            Text(
              '$_userName',
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'Pacifico',
                color: Colors.white,
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 3)),
            Text(
              'Researcher',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFFCBDCF1),
                fontFamily: 'Space Mono',
              ),
            ),
            Padding(padding: EdgeInsets.only(bottom: 5)),

            ///////////////////Container with TextField UserName
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.only(top: 32)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SizedBox(
                          child: TextFormField(
                            controller: _userNameController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color.fromARGB(255, 228, 233, 251),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              suffixIcon: Icon(
                                Icons.edit_outlined,
                                color: Color(0xFF1D5D9B),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 5),
                              label: Text(
                                'Name',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFF1D5D9B),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(
                                  color: Color(0xFF047EB0),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                                borderSide: BorderSide(
                                  color: Color(0xFF88AACA),
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF88AACA),
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _userName =
                                    value; // Update the user's name when it changes
                              });
                            },
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.only(bottom: 25),
                      ),

                      /////////////////// TextField Email
                      CustomTextFormField(
                        controller: _emailController,
                        iconData: Icons.edit_outlined,
                        labelText: 'Email',
                        labelColor: Color(0xFF1D5D9B),
                        labelFontSize: 20,
                        labelFontWeight: FontWeight.bold,
                      ),

                      Padding(
                        padding: EdgeInsets.only(bottom: 30),
                      ),

                      /////////////////// TextField Job
                      CustomTextFormField(
                        controller: _JobController,
                        iconData: Icons.edit_outlined,
                        labelText: 'Job Description',
                        labelColor: Color(0xFF1D5D9B),
                        labelFontSize: 20,
                        labelFontWeight: FontWeight.bold,
                      ),

                      Padding(
                        padding: EdgeInsets.only(bottom: 30),
                      ),

                      /////////////////// TextField Country
                      CustomTextFormField(
                        controller: _countryController,
                        iconData: Icons.edit_outlined,
                        labelText: 'Country',
                        labelColor: Color(0xFF1D5D9B),
                        labelFontSize: 20,
                        labelFontWeight: FontWeight.bold,
                      ),

                      Padding(
                        padding: EdgeInsets.only(bottom: 30),
                      ),

                      /////////////////// TextField Mobile
                      CustomTextFormField(
                        controller: _mobileController,
                        iconData: Icons.edit_outlined,
                        labelText: 'Mobile',
                        labelColor: Color(0xFF1D5D9B),
                        labelFontSize: 20,
                        labelFontWeight: FontWeight.bold,
                      ),

                      Padding(
                        padding: EdgeInsets.only(bottom: 40),
                      ),

                      ///////////////////Button for save changes
                      GestureDetector(
                        onTap: () {
                          ////logic for firebase
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color(0xFFF1CF5F),
                          ),
                          width: 348,
                          height: 60,
                          child: Center(
                            child: Text(
                              'Update Profile',
                              style: TextStyle(
                                  fontSize: 25, fontFamily: 'MulishRomanBold'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.blue[100],
        context: context,
        builder: (builder) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 4.5,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        getimage();
                      },
                      child: const SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.image,
                              size: 70,
                            ),
                            Text("Gallery")
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        getimage();
                      },
                      child: const SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 70,
                            ),
                            Text("Camera")
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  getimage() async {
    final ImagePicker picker = ImagePicker();
// Pick an image.
    final XFile? imagegallery =
        await picker.pickImage(source: ImageSource.gallery);
    if (imagegallery != null) {
      file = File(imagegallery!.path);
      //upload image
      var imagename = basename(imagegallery!.path);

      var refstorage = FirebaseStorage.instance.ref(imagename);
      await refstorage.putFile(file!);
    }
    setState(() {});
  }
}
