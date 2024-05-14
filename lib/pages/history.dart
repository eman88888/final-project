import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalproject/screens/bottomnavbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class history extends StatefulWidget {
  const history({Key? key}) : super(key: key);

  @override
  State<history> createState() => _historyState();
}

class _historyState extends State<history> {
  //////////
  Future<List<Map<String, dynamic>>> fetchUserHistory() async {
    try {
      String currentUserID = FirebaseAuth.instance.currentUser!.uid;
      QuerySnapshot historySnapshot = await FirebaseFirestore.instance
          .collection('history')
          .where('id', isEqualTo: currentUserID)
          .get();

      List<Map<String, dynamic>> userHistory = historySnapshot.docs.map((doc) {
        Map<String, dynamic> data = {
          'input': doc['input'],
          'result': doc['result'],
          'category': doc['category'],
          'date': doc['date'],
        };
        return data;
      }).toList();

      return userHistory;
    } catch (e) {
      print('Failed to fetch user history: $e');
      return []; // Return an empty list in case of failure
    }
  }

  /////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
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
                color: Colors.black,
              ),
            ),
          ),
          Container(
            //  margin: EdgeInsets.only(bottom: 15),
            height: 163,
            child: Image.asset("assets/image6.png"),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              "Recent Projects",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    left: 10,
                  ),
                  height: 162,
                  width: 80,
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xff1D5D9B), width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Text(
                        "input :",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                      Spacer(),
                      Text(
                        "section :",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                      Spacer(),
                      Text(
                        "date :",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                      Spacer(),
                      Text(
                        "Result :",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 250,
                  height: 162,
                  decoration: BoxDecoration(
                      color: Color(0xffBBCEE1),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xff000000),
                            offset: Offset(0, 4),
                            blurRadius: 4,
                            spreadRadius: 0)
                      ]),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    left: 10,
                  ),
                  height: 162,
                  width: 80,
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xff1D5D9B), width: 2),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Text(
                        "input :",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                      Spacer(),
                      Text(
                        "section :",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                      Spacer(),
                      Text(
                        "date :",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                      Spacer(),
                      Text(
                        "Result :",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 250,
                  height: 162,
                  decoration: BoxDecoration(
                      color: Color(0xffBBCEE1),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xff000000),
                            offset: Offset(0, 4),
                            blurRadius: 4,
                            spreadRadius: 0)
                      ]),
                  child: Column(
                    children: [],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
