import 'package:finalproject/screens/bottomnavbar.dart';
import 'package:finalproject/widget/custom_Button.dart';
import 'package:finalproject/widget/custom_TextField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class Signup_Screen extends StatelessWidget {
  //text editing controller
  final FullNameController = TextEditingController();
  final userController = TextEditingController();
  final passController = TextEditingController();
  final ConfirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
            CustomTextField(
              controller: FullNameController,
              hintText: 'Full Name',
            ),

            ////Textfield for Email
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: CustomTextField(
                controller: userController,
                hintText: 'Email',
              ),
            ),

            ////Textfield for Password
            Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: CustomTextField(
                obscureText: true,
                controller: passController,
                hintText: 'Password',
              ),
            ),

            ////Textfield for Confirm Password
            Padding(
              padding: EdgeInsets.only(bottom: 32),
              child: CustomTextField(
                obscureText: true,
                controller: ConfirmPassController,
                hintText: 'Confirm Password',
              ),
            ),

            ////Login Button
            Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: GestureDetector(
                  onTap: () async {
                    try {
                      final credential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: userController.text,
                        password: passController.text,
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BottomNavBar()),
                      );
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        print('The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        print('The account already exists for that email.');
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: customButton(
                    text: 'Sign Up',
                  ),
                )),

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
                        Navigator.pop(context);
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
