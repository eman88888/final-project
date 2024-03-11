import 'dart:ui';
import 'package:finalproject/pages/login_screen.dart';
import 'package:finalproject/screens/profile.dart';
import 'package:finalproject/widget/content-moadel.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Onbording extends StatefulWidget {
  @override
  _OnbordingState createState() => _OnbordingState();
}

class _OnbordingState extends State<Onbording> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _controller,
              itemCount: contents.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
                var content = contents[i];
                return Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.topRight,
                        child: TextButton(
                          child: Text(
                            currentIndex == contents.length - 1
                                ? " "
                                : " Skip ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.normal,
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Login_Screen()),
                            );
                          },
                        ),
                      ),
                      Image.asset(
                        contents[i].image,
                        height: 300,
                      ),
                      Padding(padding: EdgeInsets.all(8)),
                      Text(
                        content.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(padding: EdgeInsets.all(8)),
                      SizedBox(height: 20),
                      Text(
                        contents[i].discription,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          Column(
            children: [
              Container(
                height: 60,
                margin: EdgeInsets.all(32),
                width: 300,
                child: MaterialButton(
                  child: Text(
                    currentIndex == contents.length - 1 ? "Start" : "Next",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    if (currentIndex == contents.length - 1) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Login_Screen(),
                        ),
                      );
                    }
                    ;
                    _controller.nextPage(
                      duration: Duration(milliseconds: 100),
                      curve: Curves.bounceIn,
                    );
                  },
                  color: Color(0xffF4D160),
                  textColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  axisDirection: Axis.horizontal,
                  effect: ExpandingDotsEffect(
                      expansionFactor: 3,
                      spacing: 8.0,
                      radius: 20,
                      dotWidth: 10,
                      dotHeight: 10,
                      dotColor: Color(0xffe6ecef),
                      activeDotColor: Colors.yellow),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
