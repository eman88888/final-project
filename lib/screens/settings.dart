//setting
import 'package:finalproject/pages/EditProfilePage.dart';
import 'package:finalproject/pages/change_pass.dart';
import 'package:finalproject/pages/info.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: camel_case_types
class Setting_Page extends StatefulWidget {
  const Setting_Page({super.key});

  @override
  State<Setting_Page> createState() => _SettingPageState();
 
}

final Stream<QuerySnapshot> documentStream = FirebaseFirestore.instance
    .collection('users')
    .where("id", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
    .snapshots();

class _SettingPageState extends State<Setting_Page> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: documentStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: ModalProgressHUD(
                inAsyncCall: true,
                child: SizedBox.shrink(),
              ),
            );
          }

          return Scaffold(
            backgroundColor: const Color(0xFF1D5D9B),
            body: Column(
              children: [
                const Row(
                  children: [
                    ////Text Setting
                    Padding(
                      padding: EdgeInsets.only(top: 30, left: 20, right: 185),
                      child: Text(
                        'Setting',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Space Mono',
                          fontSize: 39,
                        ),
                      ),
                    ),
                  ],
                ),
                ////Divider
                const Divider(
                  color: Color(0xFF5E7A8C),
                  thickness: 0.9,
                ),

                /////Profile image
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 10),
                  child: Stack(
                    children: [
                      snapshot.data!.docs.isNotEmpty
                          ? snapshot.data!.docs.last['url'] != ''
                              ? CircleAvatar(
                                  radius: 90,
                                  backgroundImage: NetworkImage(
                                      snapshot.data!.docs.last['url']),
                                )
                              : const CircleAvatar(
                                  radius: 90,
                                  backgroundImage: AssetImage(
                                    "assets/profile.png",
                                  ),
                                )
                          : const CircleAvatar(
                              radius: 90,
                              backgroundImage: AssetImage(
                                "assets/profile.png",
                              ),
                            ),
                    ],
                  ),
                ),
                //////////Username Text
                Text(
                  snapshot.hasData && snapshot.data!.docs.isNotEmpty
                      ? snapshot.data!.docs.last['full_name']
                      : (FirebaseAuth.instance.currentUser?.displayName ?? ''),
                  style: const TextStyle(
                    fontSize: 30,
                    fontFamily: 'Pacifico',
                    color: Colors.white,
                  ),
                ),

                const Padding(padding: EdgeInsets.only(bottom: 10)),

                ////////////////////////////////Bottom Container
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 20),

                            ///////ListTile for Accounts
                            child: Card(
                              margin: EdgeInsets.symmetric(horizontal: 30),
                              color: Color.fromARGB(255, 228, 233, 251),
                              shadowColor: Color(0xFFE4E9FB),
                              child: ListTile(
                                title: Padding(
                                  padding: EdgeInsets.only(bottom: 3),
                                  child: Text(
                                    'ACCOUNTS',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF1D5D9B),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const Padding(
                            padding: EdgeInsets.only(bottom: 30),
                          ),

                          ///////ListTile for Edit Profile
                          Card(
                            color: Colors.white,
                            margin: const EdgeInsets.symmetric(horizontal: 40),
                            child: ListTile(
                              leading: const Icon(
                                Icons.person_pin_outlined,
                                color: Color(0xFF1D5D9B),
                              ),
                              title: const Center(
                                child: Text(
                                  'Edit Profile',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Color(0xFF1D5D9B)),
                                ),
                              ),
                              trailing: const Icon(
                                Icons.arrow_forward_outlined,
                                color: Color(0xFF1D5D9B),
                              ),
                              onTap: () {
                                ///Push to Edit profile page
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const EditProfile_Page()),
                                );
                              },
                            ),
                          ),

                          const Padding(
                            padding: EdgeInsets.only(bottom: 20),
                          ),

                          ///////ListTile for Change Pass
                          Card(
                            color: Colors.white,
                            margin: const EdgeInsets.symmetric(horizontal: 40),
                            child: ListTile(
                              leading: const Icon(
                                Icons.key_outlined,
                                color: Color(0xFF1D5D9B),
                              ),
                              title: const Center(
                                child: Text(
                                  'Change Password',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Color(0xFF1D5D9B)),
                                ),
                              ),
                              trailing: const Icon(
                                Icons.arrow_forward_outlined,
                                color: Color(0xFF1D5D9B),
                              ),
                              onTap: () {
                                ///push to Change Password
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const change()),
                                );
                              },
                            ),
                          ),

                          const Padding(
                            padding: EdgeInsets.only(bottom: 20),
                          ),

                          ////Divider
                          const Divider(
                            color: Color(0xFF5E7A8C),
                            thickness: 0.7,
                            endIndent: 20,
                            indent: 20,
                          ),

                          const Padding(
                            padding: EdgeInsets.only(bottom: 20),
                          ),

                          ///////ListTile for Prefernces
                          const Card(
                            margin: EdgeInsets.symmetric(horizontal: 30),
                            color: Color.fromARGB(255, 228, 233, 251),
                            shadowColor: Color(0xFFE4E9FB),
                            child: ListTile(
                              title: Padding(
                                padding: EdgeInsets.only(bottom: 3),
                                child: Text(
                                  'APPEARANCE',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1D5D9B),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const Padding(
                            padding: EdgeInsets.only(bottom: 30),
                          ),

                          ///////ListTile for Information
                          Card(
                            color: Colors.white,
                            margin: const EdgeInsets.symmetric(horizontal: 40),
                            child: ListTile(
                              leading: const Icon(
                                Icons.info_outlined,
                                color: Color(0xFF1D5D9B),
                              ),
                              title: const Center(
                                child: Text(
                                  'Info',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Color(0xFF1D5D9B)),
                                ),
                              ),
                              trailing: const Icon(
                                Icons.arrow_forward_outlined,
                                color: Color(0xFF1D5D9B),
                              ),
                              onTap: () {
                                ///push to Information Pge
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const info()),
                                );
                              },
                            ),
                          ),

                          const Padding(
                            padding: EdgeInsets.only(bottom: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
