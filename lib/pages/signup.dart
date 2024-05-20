import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/pages/login_screen.dart';
import 'package:finalproject/screens/bottomnavbar.dart';
import 'package:finalproject/widget/custom_Button.dart';
import 'package:finalproject/widget/custom_TextFormField2.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: camel_case_types
class Signup_Screen extends StatefulWidget {
  const Signup_Screen({super.key});

  @override
  State<Signup_Screen> createState() => _Signup_ScreenState();
}

// ignore: camel_case_types
class _Signup_ScreenState extends State<Signup_Screen> {
  //text editing controller
  // ignore: non_constant_identifier_names
  final FullNameController = TextEditingController();

  final userController = TextEditingController();

  final passController = TextEditingController();

  // ignore: non_constant_identifier_names
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
                        color: const Color(0xFFF1F4FF),
                      ),
                    ),
                    Positioned(
                      top: 80,
                      right: 60,
                      child: Transform.rotate(
                        angle: 0, // 45 degrees in radians
                        child: const Text(
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
                        child: const Text(
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
                    return null;
                  },
                  controller: FullNameController,
                  hintText: 'Full Name',
                ),

                ////Textfield for Email
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: CustomTextFormField2(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!_isValidEmail(value)) {
                        return 'Email must not contain special characters';
                      }
                      return null;
                    },
                    controller: userController,
                    hintText: 'Email',
                  ),
                ),

                ////Textfield for Password
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: CustomTextFormField2(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.length > 8) {
                        return 'Email must not be longer than 8 characters';
                      }
                      return null;
                    },
                    obscureText: true,
                    controller: passController,
                    hintText: 'Password',
                  ),
                ),

                ////Textfield for Confirm Password
                Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: CustomTextFormField2(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (value != passController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    obscureText: true,
                    controller: ConfirmPassController,
                    hintText: 'Confirm Password',
                  ),
                ),

                ////Signup Button
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: GestureDetector(
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          isLoading =
                              true; // Update isLoading state before awaiting Firebase authentication
                        });
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
                            // ignore: use_build_context_synchronously
                            context,
                            MaterialPageRoute(
                                builder: (context) => const BottomNavBar()),
                          );
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: const Color(0xFF1D5D9B),
                                duration: const Duration(seconds: 2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(
                                      color: Colors.white, width: 2),
                                ),
                                content: const Text(
                                  'The password provided is too weak.',
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Color(0xFFF1F4FF),
                                  ),
                                ),
                              ),
                            );
                          } else if (e.code == 'email-already-in-use') {
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: const Color(0xFF1D5D9B),
                                duration: const Duration(seconds: 2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(
                                      color: Colors.white, width: 2),
                                ),
                                content: const Text(
                                  'Email already exists.',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Color(0xFFF1F4FF),
                                  ),
                                ),
                              ),
                            );
                          }
                        }

                        setState(() {
                          isLoading =
                              false; // Update isLoading state after Firebase authentication
                        });
                      } else {}
                    },
                    child: const customButton(
                      text: 'Sign Up',
                    ),
                  ),
                ),

                ////-Or continue with-
                const Padding(
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
                    const SizedBox(
                      width: 40,
                    ),
                    Expanded(
                      child: Container(
                          alignment: Alignment.center,
                          height: 55,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F4FF),
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
                    const SizedBox(
                      width: 30,
                    ),
                    ///////Facebook
                    Expanded(
                      child: Container(
                          alignment: Alignment.center,
                          height: 55,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F4FF),
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
                    const SizedBox(
                      width: 30,
                    ),
                    /////////Twitter
                    Expanded(
                      child: Container(
                          alignment: Alignment.center,
                          height: 55,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F4FF),
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
                    const SizedBox(
                      width: 40,
                    ),
                  ],
                ),
                //Row for 2 texts don't have an account? and signup
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account?",
                        style: TextStyle(
                          fontFamily: 'MulishRomanBold',
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const Login_Screen()),
                            );
                          },
                          child: const Text(
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
