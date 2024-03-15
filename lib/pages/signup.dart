import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/pages/login_screen.dart';
import 'package:finalproject/screens/bottomnavbar.dart';
import 'package:finalproject/widget/custom_Button.dart';
import 'package:finalproject/widget/custom_TextField.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Signup_Screen extends StatefulWidget {
  @override
  State<Signup_Screen> createState() => _Signup_ScreenState();
}

class _Signup_ScreenState extends State<Signup_Screen> {
  //text editing controller
  final FullNameController = TextEditingController();

  final userController = TextEditingController();

  final passController = TextEditingController();

  final ConfirmPassController = TextEditingController();

  bool isLoading = false;

  bool _isValidEmail(String email) {
    // Regular expression to check if the email contains only alphanumeric characters
    RegExp regExp = RegExp(r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return regExp.hasMatch(email);
  }

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                ///Stack for Clippath (Curve) and Text (Login Here) Text (Welcome Back)
                Stack(
                  children: [
                    ClipPath(
                      clipper: MyClipper(),
                      child: Container(
                        width: 500,
                        height: 250,
                        color: Color(0xFFF1F4FF),
                      ),
                    ),
                    Positioned(
                      top: 80,
                      right: 60,
                      child: Transform.rotate(
                        angle: 0, // 45 degrees in radians
                        child: Text(
                          'Create Account',
                          style: TextStyle(
                            fontFamily: 'MulishRomanBold',
                            color: Color(0xFF1D5D9B),
                            fontSize: 40,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 140,
                      right: 72,
                      child: Transform.rotate(
                        angle: 0, // 45 degrees in radians
                        child: Text(
                          'To explore all features',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'MulishRomanBold',
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

////Textfield for Full Name
                CustomTextFormField2(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                  },
                  controller: FullNameController,
                  hintText: 'Full Name',
                ),

                ////Textfield for Email
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: CustomTextFormField2(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!_isValidEmail(value)) {
                        return 'Email must not contain special characters';
                      }
                    },
                    controller: userController,
                    hintText: 'Email',
                  ),
                ),

                ////Textfield for Password
                Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: CustomTextFormField2(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.length > 8) {
                        return 'Email must not be longer than 8 characters';
                      }
                    },
                    obscureText: true,
                    controller: passController,
                    hintText: 'Password',
                  ),
                ),

                ////Textfield for Confirm Password
                Padding(
                  padding: EdgeInsets.only(bottom: 32),
                  child: CustomTextFormField2(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (value != passController.text) {
                        return 'Passwords do not match';
                      }
                    },
                    obscureText: true,
                    controller: ConfirmPassController,
                    hintText: 'Confirm Password',
                  ),
                ),

////Signup Button
                Padding(
                  padding: EdgeInsets.only(bottom: 40),
                  child: GestureDetector(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});
                        try {
                          final credential = await FirebaseAuth.instance
                              .createUserWithEmailAndPassword(
                            email: userController.text,
                            password: passController.text,
                          );

                          // Save the name and email to Firestore
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(credential.user!.uid)
                              .set({
                            'name': FullNameController.text,
                            'email': userController.text,
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BottomNavBar()),
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Color(0xFF1D5D9B),
                                content: Text(
                                  'The password provided is too weak.',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color(0xFFF1F4FF),
                                  ),
                                ),
                              ),
                            );
                          } else if (e.code == 'email-already-in-use') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Color(0xFF1D5D9B),
                                content: Text(
                                  'Email already exists.',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Color(0xFFF1F4FF),
                                  ),
                                ),
                              ),
                            );
                          }
                        }

                        isLoading = false;
                        setState(() {});
                      } else {}
                    },
                    child: customButton(
                      text: 'Sign Up',
                    ),
                  ),
                ),

                ////-Or continue with-
                Padding(
                  padding: EdgeInsets.only(bottom: 25),
                  child: Text(
                    '-Or continue with-',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1D5D9B),
                      fontSize: 19,
                    ),
                  ),
                ),

////Row for google, facebook, twitter sign in Button
                Row(
                  children: [
                    ///////Google
                    SizedBox(
                      width: 40,
                    ),
                    Expanded(
                      child: Container(
                          alignment: Alignment.center,
                          height: 55,
                          decoration: BoxDecoration(
                            color: Color(0xFFF1F4FF),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: SvgPicture.asset(
                            'assets/GoogleLogo_icon.svg',
                            height: 25,
                          )),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    ///////Facebook
                    Expanded(
                      child: Container(
                          alignment: Alignment.center,
                          height: 55,
                          decoration: BoxDecoration(
                            color: Color(0xFFF1F4FF),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: SvgPicture.asset(
                            'assets/FacebookLogo_icon.svg',
                            height: 25,
                          )),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    /////////Twitter
                    Expanded(
                      child: Container(
                          alignment: Alignment.center,
                          height: 55,
                          decoration: BoxDecoration(
                            color: Color(0xFFF1F4FF),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: SvgPicture.asset(
                            'assets/TwitterLogo_icon.svg',
                            height: 25,
                          )),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                  ],
                ),
                //Row for 2 texts don't have an account? and signup
                Padding(
                  padding: EdgeInsets.only(top: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(
                          fontFamily: 'MulishRomanBold',
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => Login_Screen()),
                            );
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontFamily: 'MulishRomanBold',
                              color: Color(0xFF1D5D9B),
                              height: 1.7,
                              fontSize: 18,
                              decoration: TextDecoration.underline,
                              decorationColor: Color(0xFF1D5D9B),
                              decorationThickness: 2.0,
                              decorationStyle: TextDecorationStyle.solid,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width, 0); // Move to top-right corner
    path.lineTo(size.width, size.height);
    path.quadraticBezierTo(-140, 160, size.height * 0.9, -300);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
