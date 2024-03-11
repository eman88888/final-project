import 'package:finalproject/pages/EditProfilePage.dart';
import 'package:finalproject/pages/change_pass.dart';
import 'package:finalproject/pages/info.dart';
import 'package:flutter/material.dart';

class Setting_Page extends StatefulWidget {
  const Setting_Page({super.key});

  @override
  State<Setting_Page> createState() => _SettingPageState();
}

class _SettingPageState extends State<Setting_Page> {
  /////////UserName
  String _userName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1D5D9B),
      body: Column(
        children: [
          Row(
            children: [
              ////Text Setting
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 20, right: 185),
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
          Divider(
            color: const Color(0xFF5E7A8C),
            thickness: 0.9,
          ),

          /////Profile image
          Padding(
            padding: const EdgeInsets.only(top: 30, bottom: 10),
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 90,
                  //  backgroundImage: AssetImage("assets/images/Profile.png"),
                ),
              ],
            ),
          ),

          //////////Username Text
          Text(
            'Hagar Yusuf',
            style: TextStyle(
              fontSize: 30,
              fontFamily: 'Pacifico',
              color: Colors.white,
            ),
          ),

          Padding(padding: EdgeInsets.only(bottom: 10)),

          ////////////////////////////////Bottom Container
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),

                      ///////ListTile for Accounts
                      child: Card(
                        margin: EdgeInsets.symmetric(horizontal: 30),
                        color: Color.fromARGB(255, 228, 233, 251),
                        shadowColor: Color(0xFFE4E9FB),
                        child: ListTile(
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 3),
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

                    Padding(
                      padding: EdgeInsets.only(bottom: 30),
                    ),

                    ///////ListTile for Edit Profile
                    Card(
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      child: ListTile(
                        leading: Icon(
                          Icons.person_pin_outlined,
                          color: Color(0xFF1D5D9B),
                        ),
                        title: Center(
                          child: Text(
                            'Edit Profile',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Color(0xFF1D5D9B)),
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_outlined,
                          color: Color(0xFF1D5D9B),
                        ),
                        onTap: () {
                          ///Push to Edit profile page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditProfile_Page()),
                          );
                        },
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                    ),

                    ///////ListTile for Change Pass
                    Card(
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      child: ListTile(
                        leading: Icon(
                          Icons.key_outlined,
                          color: Color(0xFF1D5D9B),
                        ),
                        title: Center(
                          child: Text(
                            'Change Password',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Color(0xFF1D5D9B)),
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_outlined,
                          color: Color(0xFF1D5D9B),
                        ),
                        onTap: () {
                          ///push to Change Password
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => change()),
                          );
                        },
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                    ),

                    ////Divider
                    Divider(
                      color: const Color(0xFF5E7A8C),
                      thickness: 0.7,
                      endIndent: 20,
                      indent: 20,
                    ),

                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                    ),

                    ///////ListTile for Prefernces
                    Card(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      color: Color.fromARGB(255, 228, 233, 251),
                      shadowColor: Color(0xFFE4E9FB),
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 3),
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

                    Padding(
                      padding: EdgeInsets.only(bottom: 30),
                    ),

                    ///////ListTile for Information
                    Card(
                      color: Colors.white,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      child: ListTile(
                        leading: Icon(
                          Icons.info_outlined,
                          color: Color(0xFF1D5D9B),
                        ),
                        title: Center(
                          child: Text(
                            'Info',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Color(0xFF1D5D9B)),
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_outlined,
                          color: Color(0xFF1D5D9B),
                        ),
                        onTap: () {
                          ///push to Information Pge
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => info()),
                          );
                        },
                      ),
                    ),

                    Padding(
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
  }
}
