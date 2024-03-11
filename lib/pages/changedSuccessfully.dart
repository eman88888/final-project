import 'package:finalproject/pages/login_screen.dart';
import 'package:flutter/material.dart';

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
            child: Image.asset('assets/change2.png'),
          ),

          /////Text for Password Changed!
          Text(
            'Password Changed!',
            style: TextStyle(
              fontSize: 30,
              color: Color(0xFF1D5D9B),
              fontWeight: FontWeight.bold,
            ),
          ),

          /////Text for Your password has been changed
          Text(
            'Your password has been changed \n                  successfully.',
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF7CA3C9),
              fontWeight: FontWeight.bold,
              fontFamily: "MulishRomanBold",
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
