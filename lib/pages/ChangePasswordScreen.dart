import 'package:finalproject/pages/changedSuccessfully.dart';
import 'package:flutter/material.dart';

import '../widget/custom_Button.dart';

class ChangePassword_Screen extends StatefulWidget {
  const ChangePassword_Screen({super.key});

  @override
  State<ChangePassword_Screen> createState() => _ChangePassword_ScreenState();
}

class _ChangePassword_ScreenState extends State<ChangePassword_Screen> {
  @override
  Widget build(BuildContext context) {
    /////text editing controller
    final NewPass = TextEditingController();
    final ConfirmNewPass = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFF1D5D9B),
      body: Column(
        children: [
          /////////////Put Image
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/image 4.png',
              width: 250,
              height: 250,
            ),
          ),

          ///////////Container()
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Column(
                children: [
                  ///////////////Text for Create New Password
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 70),
                    child: Text(
                      'Create New Password',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  ////////Text and TextField for New Password
                  Padding(
                    padding: const EdgeInsets.only(right: 210, bottom: 5.0),
                    child: Text(
                      'New Password',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                    ),
                    child: TextField(
                      controller: NewPass,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFCFDBE8),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28),
                          borderSide: BorderSide(
                            color: Color(0xFF047EB0),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(28),
                          borderSide: BorderSide(
                            color: Color(0xFFCFDBE8),
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

                  Padding(
                    padding: EdgeInsets.only(bottom: 90),
                  ),

                  ////////Text and TextField for Confirm New Password
                  Padding(
                    padding: const EdgeInsets.only(right: 130, bottom: 5.0),
                    child: Text(
                      'Confirm New Password',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                    ),
                    child: TextField(
                      controller: ConfirmNewPass,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFCFDBE8),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(64),
                          borderSide: BorderSide(
                            color: Color(0xFF047EB0),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(64),
                          borderSide: BorderSide(
                            color: Color(0xFFCFDBE8),
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

                  /////////Button for Reset
                  Padding(
                    padding: const EdgeInsets.only(top: 70),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    ChangedSuccessfully_Screen()),
                          );
                        },
                        child: customButton(text: 'Reset Password')),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
