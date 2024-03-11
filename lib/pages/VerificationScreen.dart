import 'package:finalproject/pages/ChangePasswordScreen.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../widget/custom_Button.dart';

class VerifyCode_Screen extends StatefulWidget {
  VerifyCode_Screen({super.key});

  @override
  State<VerifyCode_Screen> createState() => _VerifyCode_ScreenState();
}

class _VerifyCode_ScreenState extends State<VerifyCode_Screen> {
  ////text editing controller
  final pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ////////For Pinput
    final submittedPinTheme = PinTheme(
      width: 75,
      height: 75,
      textStyle: const TextStyle(
        fontSize: 25,
        color: Colors.black,
      ),
      decoration: BoxDecoration(
        color: Color(0xFFEFB91B),
        borderRadius: BorderRadius.circular(21),
        border: Border.all(color: Colors.white),
      ),
    );
    final focusedPinTheme = PinTheme(
      width: 75,
      height: 75,
      textStyle: const TextStyle(
        fontSize: 25,
        color: Color(0xFFEFB91B),
      ),
      decoration: BoxDecoration(
        color: Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: Colors.yellow),
      ),
    );
    final defaultPinTheme = PinTheme(
      width: 75,
      height: 75,
      textStyle: const TextStyle(
        fontSize: 25,
      ),
      decoration: BoxDecoration(
        color: Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: Color(0xFF1D5D9B)),
      ),
    );

    /////////////////////////////////////////////////////////////////////////////////////
    return Scaffold(
      backgroundColor: const Color(0xFF1D5D9B),
      body: Column(
        children: [
          /////Put Image
          Padding(
            padding: EdgeInsets.only(top: 90),
            child: Image.asset(
              'assets/verification.png',
              width: 300,
              height: 300,
            ),
          ),

          ///////Text Verify text
          const Text(
            'Verify Code',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          ///////Text Enter mail
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Please Enter The 4 Digit Code Sent To \n                      Your Mail',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Padding(padding: EdgeInsets.only(top: 70)),

          /////Pinput
          Center(
            child: Pinput(
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: focusedPinTheme,
              submittedPinTheme: submittedPinTheme,
              controller: pinController,
              cursor: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 9),
                    width: 22,
                    height: 1,
                    color: Color(0xFF1D5D9B),
                  ),
                ],
              ),
            ),
          ),

          /////Verify Button
          Padding(
            padding: const EdgeInsets.only(top: 64),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChangePassword_Screen()),
                );
              },
              child: customButton(text: 'Verify'),
            ),
          ),

          Padding(padding: EdgeInsets.only(top: 70)),

          //////Row for Don't receive and Resend
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't receive the code ? ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Resend',
                style: TextStyle(
                  fontFamily: 'MulishRomanBold',
                  color: Colors.yellow,
                  height: 1.7,
                  fontSize: 18,
                  decoration: TextDecoration.underline,
                  decorationColor: Colors.white,
                  decorationThickness: 2.0,
                  decorationStyle: TextDecorationStyle.solid,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
