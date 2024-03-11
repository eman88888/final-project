import 'package:finalproject/pages/ForgetPassScreen.dart';
import 'package:finalproject/pages/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../screens/bottomnavbar.dart';
import '../widget/custom_Button.dart';
import '../widget/custom_TextField.dart';

class Login_Screen extends StatefulWidget {
  Login_Screen({super.key});

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  //text editing controllers
  final userController = TextEditingController();
  final passController = TextEditingController();
  bool rememberUser = false;

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
                    height: 300,
                    color: Color(0xFFF1F4FF),
                  ),
                ),
                Positioned(
                  top: 120,
                  right: 120,
                  child: Transform.rotate(
                    angle: 0, // 45 degrees in radians
                    child: Text(
                      'Login Here',
                      style: TextStyle(
                        fontFamily: 'MulishRomanBold',
                        color: Color(0xFF1D5D9B),
                        fontSize: 40,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 180,
                  right: 130,
                  child: Transform.rotate(
                    angle: 0, // 45 degrees in radians
                    child: Text(
                      'Welcome Back',
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

            ////Textfield for Email
            Padding(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: CustomTextField(
                controller: userController,
                hintText: 'Email',
              ),
            ),

            ////Textfield for Password
            Padding(
              padding: EdgeInsets.only(bottom: 9),
              child: CustomTextField(
                obscureText: true,
                controller: passController,
                hintText: 'Password',
              ),
            ),

            ////Checkbox and Text Forgot password

            Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Checkbox(
                      activeColor: Color(0xFF1D5D9B),
                      value: rememberUser,
                      onChanged: (value) {
                        setState(
                          () {
                            rememberUser = value!;
                          },
                        );
                      },
                    ),
                  ),
                  Text(
                    'Remember Me',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1D5D9B),
                      fontSize: 15,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgetPass_Screen()),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 45),
                      child: Text(
                        'forgot your password?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            ////Login Button
            Padding(
                padding: EdgeInsets.only(bottom: 56),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BottomNavBar()),
                    ); ////for firebase
                  },
                  child: customButton(
                    text: 'Log In',
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

            ////Row for 2 texts don't have an account? and signup
            Padding(
              padding: EdgeInsets.only(top: 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "don't have an account?",
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Signup_Screen()),
                        );
                      },
                      child: Text(
                        'Signup',
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
    path.quadraticBezierTo(-140, 160, size.height * 0.8, -300);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
