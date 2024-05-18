import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:finalproject/screens/bottomnavbar.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

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
/////////////////
  @override
  void initState() {
    super.initState();
    // Call a function to fetch user data
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    // Get the currently authenticated user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Retrieve the document with the user's ID
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      // Check if the document exists
      if (documentSnapshot.exists) {
        // Get user data from the document
        Map<String, dynamic> userData =
            documentSnapshot.data() as Map<String, dynamic>;

        setState(() {
          _userName = userData['name'] ?? '';
        });
      }
    }
  }

  TextEditingController _userNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _JobController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  String? url;
  final Stream<QuerySnapshot> documentStream = FirebaseFirestore.instance
      .collection('users')
      .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();

  Uint8List imageBytes = Uint8List(0);

  /////build collection in firestore
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  File? selectedIMage;
  ///////

  ///////
  GlobalKey<FormState> formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: documentStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.black),
            );
          }
          CollectionReference users =
              FirebaseFirestore.instance.collection('users');

          Future<void>? addUser() {
            return users
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .set(
                  {
                    'full_name': _userNameController.text == ''
                        ? snapshot.data!.docs.isNotEmpty
                            ? snapshot.data!.docs.last['full_name']
                            : _userNameController.text
                        : _userNameController.text,
                    'email': _emailController.text == ''
                        ? snapshot.data!.docs.isNotEmpty
                            ? snapshot.data!.docs.last['email']
                            : FirebaseAuth.instance.currentUser!.email
                        : _emailController.text,
                    'job': _JobController.text == ''
                        ? snapshot.data!.docs.isNotEmpty
                            ? snapshot.data!.docs.last['job']
                            : _JobController.text
                        : _JobController.text, // Stokes and Sons
                    'country': _countryController.text == ''
                        ? snapshot.data!.docs.isNotEmpty
                            ? snapshot.data!.docs.last['country']
                            : _countryController.text
                        : _countryController.text,
                    'phone': _mobileController.text == ''
                        ? snapshot.data!.docs.isNotEmpty
                            ? snapshot.data!.docs.last['phone']
                            : _mobileController.text
                        : _mobileController.text,
                    'id': FirebaseAuth.instance.currentUser!.uid,
                    'url': url ??
                        (snapshot.data!.docs.isNotEmpty
                            ? snapshot.data!.docs.last['url']
                            : 'assets/profile.png'),
                  },
                  SetOptions(merge: true),
                )
                .then((value) =>
                    print("'full_name' & 'age' merged with existing data!"))
                .catchError((error) => print("Failed to merge data: $error"));
          }

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

                  Stack(
                    children: [
                      snapshot.data!.docs.isNotEmpty
                          ? snapshot.data!.docs.last['url'] != ''
                              ? CircleAvatar(
                                  radius: 90,
                                  backgroundImage: NetworkImage(
                                      snapshot.data!.docs.last['url']),
                                )
                              : CircleAvatar(
                                  radius: 90,
                                  backgroundImage: AssetImage(
                                    "assets/profile.png",
                                  ),
                                )
                          : CircleAvatar(
                              radius: 90,
                              backgroundImage: AssetImage(
                                "assets/profile.png",
                              ),
                            ),
                      Positioned(
                        bottom: -0,
                        left: 130,
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
                      //name from signup
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: SizedBox(
                                child: TextFormField(
                                  controller: _userNameController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor:
                                        Color.fromARGB(255, 228, 233, 251),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    suffixIcon: Icon(
                                      Icons.edit_outlined,
                                      color: Color(0xFF1D5D9B),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 5),
                                    label: const Text('Name'),
                                    labelStyle: TextStyle(
                                      color: Color(0xFF1D5D9B),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                    hintText: snapshot.data!.docs.isNotEmpty
                                        ? snapshot.data!.docs.last['full_name']
                                        : FirebaseAuth
                                            .instance.currentUser!.displayName,
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
                              hintText: snapshot.data!.docs.isNotEmpty
                                  ? snapshot.data!.docs.last['email']
                                  : FirebaseAuth.instance.currentUser!.email,
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
                                hintText: snapshot.data!.docs.isNotEmpty
                                    ? snapshot.data!.docs.last['job']
                                    : ' '),

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
                                hintText: snapshot.data!.docs.isNotEmpty
                                    ? snapshot.data!.docs.last['country']
                                    : ' '),

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
                                hintText: snapshot.data!.docs.isNotEmpty
                                    ? snapshot.data!.docs.last['phone']
                                    : ' '),

                            Padding(
                              padding: EdgeInsets.only(bottom: 40),
                            ),

                            ///////////////////Button for save changes
                            GestureDetector(
                              onTap: () async {
                                addUser();
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
                                        fontSize: 25,
                                        fontFamily: 'MulishRomanBold'),
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
        });
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
              child: InkWell(
                onTap: () async {
                  final pickedFiles = await FilePicker.platform.pickFiles(
                    type: FileType.image,
                    allowMultiple: false,
                  );

                  if (pickedFiles != null && pickedFiles.files.isNotEmpty) {
                    final imageBytes = pickedFiles.files.single.bytes;
                    if (imageBytes != null && imageBytes.isNotEmpty) {
                      var storageRef = FirebaseStorage.instance.ref().child(
                            'images/${DateTime.now().toIso8601String()}.jpg',
                          );
                      try {
                        var uploadTask = storageRef.putData(imageBytes);
                        var snapshot = await uploadTask;
                        var imageUrl = await snapshot.ref.getDownloadURL();
                        // ignore: unnecessary_null_comparison
                        if (imageUrl != null) {
                          print('Image uploaded successfully. URL: $imageUrl');
                          setState(() {
                            url = imageUrl;
                          });
                        }
                      } catch (e) {
                        print(e);
                      }
                    }
                  }
                },
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
          );
        });
  }

  // Future pickImageFromGallery(BuildContext context) async {
  //   final returnImage =
  //       await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (returnImage == null) return;

  //   setState(() {
  //     selectedIMage = File(returnImage.path);
  //     imageBytes = File(returnImage.path).readAsBytesSync();
  //   });

  //   Navigator.of(context).pop(); //close the model sheet
  // }

  // Future<String?> uploadImageToFirebase() async {
  //   if (imageBytes == null) {
  //     print('No image selected.');
  //     return null;
  //   }

  //   try {
  //     final currentUser = FirebaseAuth.instance.currentUser;
  //     if (currentUser == null) {
  //       print('User not signed in.');
  //       return null;
  //     }
  //     Reference storageReference = FirebaseStorage.instance.ref().child(
  //         "user_images/${currentUser.uid}/${DateTime.now().toIso8601String()}");
  //     await storageReference.putFile(selectedIMage!);
  //     final imageUrl = await storageReference.getDownloadURL();

  //     setState(() {
  //       url = imageUrl;
  //     });
  //     print('File uploaded successfully. Image URL: $url');
  //     return imageUrl;
  //   } on FirebaseException catch (e) {
  //     print('Error uploading file: $e');
  //     print('error');
  //     return null;
  //   }
  // }
}
