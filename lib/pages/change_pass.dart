import 'package:finalproject/screens/bottomnavbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


// ignore: camel_case_types
class change extends StatefulWidget {
  const change({Key? key}) : super(key: key);

  @override
  State<change> createState() => _changeState();
}

// ignore: camel_case_types
class _changeState extends State<change> {
  GlobalKey<FormState> formKey = GlobalKey();
  final oldpassController = TextEditingController();
  final newpassController = TextEditingController();

  Future<void> changePassword(String oldpass, String newPass) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Color(0xFF1D5D9B),
          content: Text(
            'password has been changed',
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFFF1F4FF),
            ),
          ),
        ),
      );
      await user.updatePassword(newPass);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Color(0xFF1D5D9B),
          content: Text(
            'password hasnt been changed',
            style: TextStyle(
              fontSize: 10,
              color: Color(0xFFF1F4FF),
            ),
          ),
        ),
      );
      // No user is signed in.
    }
  }

  bool isLoading = false;
  bool passwordVisible = false;
  bool passwordVisible1 = false;
  bool passwordVisible2 = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
    passwordVisible1 = true;
    passwordVisible2 = true;
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Form(
        key: formKey,
        child: Stack(
          children: [
            Container(
              height: 400,
              color: const Color(0xff1D5D9B),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: const EdgeInsets.only(top: 10),
              // height: 10,
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BottomNavBar()),
                  );
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(bottom: 20),
                height: 149,
                child: Image.asset("assets/image 4.png"),
              ),
            ),
            Positioned(
              top: 250,
              child: Container(
                width: screenSize.width,
                height: screenSize.height,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )),
                child: ListView(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "Change your password",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w700),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(10)),
                    Container(
                      padding: const EdgeInsets.only(left: 20, bottom: 10),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        " password",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your current password';
                          }
                          return null;
                        },
                        controller: oldpassController,
                        obscureText: passwordVisible,
                        decoration: InputDecoration(
                          fillColor: const Color(0xffF1F4FF),
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(
                              color: Color(0xFF047EB0),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(
                              color: Color(0xFFF1F4FF),
                            ),
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF047EB0),
                            ),
                          ),
                          suffixIcon: IconButton(
                            color: const Color(0xff035AA6),
                            icon: Icon(passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(
                                () {
                                  passwordVisible = !passwordVisible;
                                },
                              );
                            },
                          ),
                          alignLabelWithHint: false,
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(10)),
                    Container(
                       padding: const EdgeInsets.only(left: 20, bottom: 10),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        " New password",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your new password';
                          }
                          return null;
                        },
                        controller: newpassController,
                        obscureText: passwordVisible1,
                        decoration: InputDecoration(
                          fillColor: const Color(0xffF1F4FF),
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(
                              color: Color(0xFF047EB0),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(
                              color: Color(0xFFF1F4FF),
                            ),
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF047EB0),
                            ),
                          ),
                          suffixIcon: IconButton(
                            color: const Color(0xff035AA6),
                            icon: Icon(passwordVisible1
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(
                                () {
                                  passwordVisible1 = !passwordVisible1;
                                },
                              );
                            },
                          ),
                          alignLabelWithHint: false,
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(10)),
                    Container(
                      padding: const EdgeInsets.only(left: 20, bottom: 10),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        "Confirm New password",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          } else if (value != newpassController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                        obscureText: passwordVisible2,
                        decoration: InputDecoration(
                          fillColor: const Color(0xffF1F4FF),
                          filled: true,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(
                              color: Color(0xFF047EB0),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(
                              color: Color(0xFFF1F4FF),
                            ),
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF047EB0),
                            ),
                          ),
                          suffixIcon: IconButton(
                            color: const Color(0xff035AA6),
                            icon: Icon(passwordVisible2
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(
                                () {
                                  passwordVisible2 = !passwordVisible2;
                                },
                              );
                            },
                          ),
                          alignLabelWithHint: false,
                        ),
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.all(30)),
                    Container(
                      margin: const EdgeInsets.only(left:80,right: 80,bottom: 50,top: 50),
                      height: 60,
                      width: 60,
                      child: MaterialButton(
                          color: const Color(0xffF4D160),
                          textColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              setState(() {
                                isLoading =
                                    true; // Update isLoading state before awaiting Firebase authentication
                              });
                              changePassword(oldpassController.text,
                                  newpassController.text);
                            }
                          },
                          child: const Text(
                            'Change',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          )),
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                          padding: const EdgeInsets.only(left: 5.5),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const BottomNavBar()),
                              );
                            },
                            child: Image.asset(
                              "assets/home icon.png",
                              height: 35,
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
