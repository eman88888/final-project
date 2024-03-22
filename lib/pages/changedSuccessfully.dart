import 'package:finalproject/pages/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../widget/custom_Button.dart';

class ChangedSuccessfully_Screen extends StatelessWidget {
  const ChangedSuccessfully_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          //////Put image
          Padding(
            padding: const EdgeInsets.only(top: 140, bottom: 32),
            child: Image.asset('assets/send.jpg'),
          ),

          

          /////Text for Your password has been changed
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Center(
              child: Text(
                'Password reset email sent! \n  Please check your email.',
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF1D5D9B),
                  fontWeight: FontWeight.bold,
                  fontFamily: "MulishRomanBold",
                ),
              ),
            ),
          ),

          /////CustomButton
          Padding(
            padding: const EdgeInsets.only(top: 130),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login_Screen()),
                  );
                },
                child: customButton(text: 'Back to Login')),
          )
        ],
      ),
    );
  }
}
