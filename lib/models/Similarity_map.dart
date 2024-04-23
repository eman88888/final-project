import 'package:finalproject/result/similarty_result.dart';
import 'package:flutter/material.dart';

class similarity extends StatefulWidget {
  const similarity({Key? key}) : super(key: key);

  @override
  State<similarity> createState() => _similarityState();
}

class _similarityState extends State<similarity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 450,
            width: 499,
            child: Image.asset(
              "assets/Animation5.gif",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: 40,
            width: 228,
            alignment: Alignment.topCenter,
            child: const Text(
              "Similarity map",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 10),
            child: Container(
              height: 130,
              width: 384,
              alignment: Alignment.topCenter,
              child: const Text(
                "Now you can easily find similarity between two molecules using our secret feature.",
                style: TextStyle(
                  color: Color(0xff363636),
                  fontSize: 23,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30, bottom: 30),
            height: 65,
            width: 200,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 40),
                blurRadius: 40,
                spreadRadius: 0,
              )
            ]),
            child: MaterialButton(
                child: const Text(
                  'Start',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                color: const Color(0xffF4D160),
                textColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => simresult()),
                  );
                }),
          ),
        ],
      ),
    );
  }
}