import 'package:finalproject/pages/onbording.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class startscreen extends StatefulWidget {
  const startscreen({Key? key}) : super(key: key);

  @override
  State<startscreen> createState() => _startscreenState();
}

class _startscreenState extends State<startscreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    goToNextView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: const Color(0xff1D5D9B),
                borderRadius: BorderRadius.circular(25)),
          ),
          Container(
            alignment: Alignment.center,
            child: Image.asset('assets/screen logo.png'),
          )
        ],
      ),
    );
  }

  void goToNextView() {
    Future.delayed(Duration(seconds: 3), () {
      Get.to(() => Onbording(), transition: Transition.fade);
    });
  }
}
