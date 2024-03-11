import 'package:finalproject/screens/bottomnavbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../screens/settings.dart';

class change extends StatefulWidget {
  change({Key? key}) : super(key: key);

  @override
  State<change> createState() => _changeState();
}

class _changeState extends State<change> {
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
    return Scaffold(
      backgroundColor: Color(0xff1D5D9B),
      body: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            // height: 10,
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BottomNavBar()),
                );
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 30),
            height: 163,
            child: Image.asset("assets/image 4.png"),
          ),
          Container(
            height: 682,
            width: 500,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                )),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Change your password",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Container(
                  padding: EdgeInsets.only(left: 10, bottom: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    " password",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4, right: 4),
                  child: TextField(
                    obscureText: passwordVisible,
                    decoration: InputDecoration(
                      fillColor: Color(0xffF1F4FF),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          borderSide: BorderSide(color: Colors.black)),
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        color: Color(0xff035AA6),
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
                Padding(padding: EdgeInsets.all(10)),
                Container(
                  padding: EdgeInsets.only(left: 10, bottom: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    " New password",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4, right: 4),
                  child: TextField(
                    obscureText: passwordVisible1,
                    decoration: InputDecoration(
                      fillColor: Color(0xffF1F4FF),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          borderSide: BorderSide(color: Colors.black)),
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        color: Color(0xff035AA6),
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
                Padding(padding: EdgeInsets.all(10)),
                Container(
                  padding: EdgeInsets.only(left: 10, bottom: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Confirm New password",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4, right: 4),
                  child: TextField(
                    obscureText: passwordVisible2,
                    decoration: InputDecoration(
                      fillColor: Color(0xffF1F4FF),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                          borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          borderSide: BorderSide(color: Colors.black)),
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        color: Color(0xff035AA6),
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
                Padding(padding: EdgeInsets.all(30)),
                Container(
                  margin: const EdgeInsets.all(8),
                  height: 60,
                  width: 262,
                  child: MaterialButton(
                      child: const Text(
                        'Change',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      color: const Color(0xffF4D160),
                      textColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onPressed: () {}),
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 5.0, top: 100),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BottomNavBar()),
                          );
                        },
                        child: SvgPicture.asset(
                          "assets/homepages_icon.svg",
                          height: 35,
                        ),
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
