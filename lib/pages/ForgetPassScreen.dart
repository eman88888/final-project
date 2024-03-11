import 'package:finalproject/pages/VerificationScreen.dart';
import 'package:flutter/material.dart';
import '../widget/custom_Button.dart';

class ForgetPass_Screen extends StatefulWidget {
  const ForgetPass_Screen({super.key});

  @override
  State<ForgetPass_Screen> createState() => _ForgetPass_ScreenState();
}

class _ForgetPass_ScreenState extends State<ForgetPass_Screen> {
  @override
  Widget build(BuildContext context) {
    ////text editing controller
    final mailAddress = TextEditingController();

    return Scaffold(
      backgroundColor: Color(0xFF1D5D9B),
      body: Column(
        children: [
          /////Image
          Padding(
            padding: EdgeInsets.only(top: 90),
            child: Image.asset(
              'assets/image 4.png',
              width: 300,
              height: 300,
            ),
          ),

          ///////Forget pass text
          Text(
            'Forget Password?',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          ///////Text Enter mail
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Please Enter Your Email Address To \n      Receive a Verification Code',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 90)),

          /////Text Mail Address
          Padding(
            padding: const EdgeInsets.only(right: 170),
            child: Text(
              'Email Address',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 8.0),
          ),

          ////Textfield for enter mail
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: TextField(
              controller: mailAddress,
              decoration: InputDecoration(
                hintText: 'mail@example.com',
                hintStyle: TextStyle(
                  color: Color(0xff678BAD),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                filled: true,
                fillColor: Color(0xFF4A7BAA),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: Color(0xFF047EB0),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: Color(0xFF4A7BAA),
                  ),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF4A7BAA),
                  ),
                ),
              ),
            ),
          ),

          /////Button to go to verifiction code
          Padding(
            padding: const EdgeInsets.only(top: 64),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VerifyCode_Screen()),
                  );
                },
                child: customButton(text: 'Send Code')),
          ),
        ],
      ),
    );
  }
}
