import 'package:finalproject/pages/changedSuccessfully.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
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

    GlobalKey<FormState> formKey = GlobalKey();

    bool _isValidEmail(String email) {
      // Regular expression to check if the email contains only alphanumeric characters
      RegExp regExp = RegExp(r'^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
      return regExp.hasMatch(email);
    }

    bool isLoading = false;

    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: Color(0xFF1D5D9B),
        body: Form(
          key: formKey,
          child: Column(
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
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!_isValidEmail(value)) {
                      return 'Email must not contain special characters';
                    }
                  },
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
                    onTap: () async {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          await FirebaseAuth.instance.sendPasswordResetEmail(
                            email: mailAddress.text,
                          );
                          // Show snackbar to inform the user that the password reset email has been sent
                         
                          // Navigate to login page
                          Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ChangedSuccessfully_Screen()),
                    );
                        } on FirebaseAuthException catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('Failed to send password reset email.'),
                            ),
                          );
                        }
                        setState(() {
                          isLoading = false;
                        });
                      }
                      //////email#######
                    },
                    child: customButton(text: 'Reset password')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
