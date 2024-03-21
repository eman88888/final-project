import 'dart:io';

import 'package:finalproject/widget/custom_TextFormField2.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import 'package:finalproject/screens/bottomnavbar.dart';
import 'package:finalproject/screens/settings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
////////////
import '../widget/custom_TextFormField1.dart';
//firebase
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditProfile_Page extends StatefulWidget {
  EditProfile_Page({super.key});

  @override
  State<EditProfile_Page> createState() => _PickImageState();
}

class _PickImageState extends State<EditProfile_Page> {
  /////////////UserName
  String _userName = '';
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _JobController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  String? url;

  /////build collection in firestore
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  final FirebaseAuth _auth = FirebaseAuth.instance;
  ////////For image
  Uint8List? _image;
  File? selectedIMage;
  ///////

  @override
  void initState() {
    super.initState();
    // Call a function to fetch user data
    fetchUserData();
  }

  /////
  Future<void> fetchUserData() async {
    // Get the currently authenticated user
    User? user = _auth.currentUser;

    if (user != null) {
      // Retrieve the document with the user's ID
      DocumentSnapshot documentSnapshot = await users.doc(user.uid).get();

      // Check if the document exists
      if (documentSnapshot.exists) {
        // Get user data from the document
        Map<String, dynamic> userData =
            documentSnapshot.data() as Map<String, dynamic>;

        setState(() {
          _userName = userData['name'] ?? '';
        });

        // Set user data into text controllers

        _userNameController.text = userData['name'] ?? '';
        _emailController.text = userData['email'] ?? '';
        _JobController.text = userData['job'] ?? '';
        _countryController.text = userData['country'] ?? '';
        _mobileController.text = userData['mobile'] ?? '';
      }
    }
  }

  Future<void> updateUserProfile() async {
    // Get the currently authenticated user
    User? user = _auth.currentUser;

    if (user != null && mounted) {
      try {
        // Verify the new email before updating
        await user.verifyBeforeUpdateEmail(_emailController.text);

        // Update user data in Firestore
        await users.doc(user.uid).update({
          "name": _userNameController.text,
          "email": _emailController.text,
          "job": _JobController.text,
          "country": _countryController.text,
          "mobile": _mobileController.text,
        });

        // Data updated successfully
        print("User data updated successfully");
        // Show snackbar with the message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Update done',
              style: TextStyle(color: Color(0xFFF1F4FF), fontSize: 15),
            ),
            backgroundColor: Color(0xFF1D5D9B),
            duration: Duration(seconds: 2),
          ),
        );
      } catch (error) {
        // Failed to update data
        print("Failed to update user data: $error");
        // Show snackbar with the message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Update failed',
              style: TextStyle(color: Color(0xFFF1F4FF), fontSize: 15),
            ),
            backgroundColor: Color(0xFF1D5D9B),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  } ////////////////////////

  Future<String?> uploadImageToFirebase() async {
    if (_image == null) {
      print('No image selected.');
      return null;
    }

    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        print('User not signed in.');
        return null;
      }
      Reference storageReference = FirebaseStorage.instance.ref().child(
          "user_images/${currentUser.uid}/${DateTime.now().toIso8601String()}");
      await storageReference.putFile(selectedIMage!);
      final imageUrl = await storageReference.getDownloadURL();
      setState(() {
        url = imageUrl;
      });

      print('File uploaded successfully. Image URL: $url');
      return imageUrl;
    } on FirebaseException catch (e) {
      print('Error uploading file: $e');
      return null;
    }
  }

  ///////
  GlobalKey<FormState> formKey = GlobalKey();
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
                    MaterialPageRoute(builder: (context) => Setting_Page()),
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
                        backgroundImage: AssetImage("assets/profile.png"),
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
                      borderRadius: BorderRadius.circular(30), // Border radius
                    ),
                    child: IconButton(
                      color: Color(0xFF1D5D9B),
                      iconSize: 20,
                      onPressed: () {
                        showImagePickerOption(context);
                      },
                      icon: const Icon(
                        Icons.add_a_photo,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            ///// Display the user's name below the input field
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 7),
              child: Text(
                _userName,
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Pacifico',
                  color: Colors.white,
                ),
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
                      ), /////////////////// TextField Job
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
                        onTap: () async {
                          String? uploadedImageUrl =
                              await uploadImageToFirebase();
                          if (uploadedImageUrl != null) {
                            setState(() {
                              url = uploadedImageUrl;
                            });
                            updateUserProfile();
                          }
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
                        _pickImageFromGallery();
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
                        _pickImageFromCamera();
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

  //Gallery
  Future _pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedIMage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Navigator.of(context).pop(); //close the model sheet
  }

//Camera
  Future _pickImageFromCamera() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      selectedIMage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Navigator.of(context).pop();
  }

/////addusers
  Future<void> addUser() async {
    // Check for null values in required fields
    if (_userNameController.text.isEmpty || // <- Add a comma here
        _emailController.text.isEmpty ||
        _JobController.text.isEmpty ||
        _countryController.text.isEmpty ||
        _mobileController.text.isEmpty) {
      // Show an error message indicating required fields are empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in all required fields.'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // Add user data to Firestore
    await users.add({
      "name": _userNameController.text,
      "email": _emailController.text,
      "job": _JobController.text,
      "country": _countryController.text,
      "mobile": _mobileController.text,
    }).then((value) {
      print("User Added");
      // Navigate back to Setting_Page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Setting_Page()),
      );
    }).catchError((error) => print("Failed to add user: $error"));
  }
}
