import 'package:finalproject/pages/history.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _userName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                SizedBox(
                  height: 420,
                  child: Container(
                    color: Color(0xFF1D5D9B),
                    child: Stack(
                      children: [
                        Container(
                          margin:
                              EdgeInsets.only(left: 120, right: 120, top: 60),
                          child: CircleAvatar(
                            radius: 90,
                            // backgroundImage:
                            //  AssetImage("assets/hagar.jpg"),
                          ),
                        ),
                        Positioned(
                          bottom: 100,
                          left: 0,
                          right: 0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Hagar Yusuf',
                                style: TextStyle(
                                  fontSize: 30,
                                  fontFamily: 'Pacifico-Regular',
                                  color: Colors.white,
                                ),
                              ),
                              Padding(padding: EdgeInsets.only(bottom: 5)),
                              Text(
                                'Researcher',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFCBDCF1),
                                  fontFamily: 'Space Mono',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 350, // Adjust the top position as needed
            left: 30,
            right: 30,
            child: Container(
              width:
                  MediaQuery.of(context).size.width, // Full width of the screen
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Shadow color
                    spreadRadius: 1, // Spread radius
                    blurRadius: 3, // Blur radius
                    offset: Offset(0, 2), // Offset
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Column(
                children: [
                  ///////////////////////////////////////////NAME
                  ListTile(
                    leading: Icon(
                      Icons.person_outline_outlined,
                      color: Color(0xFF1D5D9B),
                      size: 30,
                    ),
                    title: Text(
                      'Hagar Muhammad Ali Yusuf ',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        //fontWeight: FontWeight.bold
                      ),
                    ),
                  ),

                  Divider(
                    thickness: 0.1,
                    color: Colors.grey[350],
                  ),

                  ListTile(
                    ///////////////////////////////////////////Email
                    leading: Icon(Icons.email_outlined,
                        color: Color(0xFF1D5D9B), size: 30),
                    title: Text(
                      'hagarysusf1@gmail.com ',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        //fontWeight: FontWeight.bold
                      ),
                    ),
                  ),

                  Divider(
                    thickness: 0.1,
                    color: Colors.grey[350],
                  ),

                  ListTile(
                    ///////////////////////////////////////////Job
                    leading: Icon(Icons.work_outline_outlined,
                        color: Color(0xFF1D5D9B), size: 30),
                    title: Text(
                      'Teaching at university',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        //fontWeight: FontWeight.bold
                      ),
                    ),
                  ),

                  Divider(
                    thickness: 0.1,
                    color: Colors.grey[350],
                  ),

                  ListTile(
                    ///////////////////////////////////////////Country
                    leading: Icon(Icons.location_on_outlined,
                        color: Color(0xFF1D5D9B), size: 30),
                    title: Text(
                      'Egypt',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        //fontWeight: FontWeight.bold
                      ),
                    ),
                  ),

                  Divider(
                    thickness: 0.1,
                    color: Colors.grey[350],
                  ),

                  ListTile(
                    ///////////////////////////////////////////Mobile
                    leading: Icon(Icons.phone_enabled_outlined,
                        color: Color(0xFF1D5D9B), size: 30),
                    title: Text(
                      '01222579576',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        //fontWeight: FontWeight.bold
                      ),
                    ),
                  ),

                  Divider(
                    thickness: 0.1,
                    color: Colors.grey[350],
                  ),

                  ListTile(
                    ///////////////////////////////////////////History
                    leading: Icon(
                      Icons.history_edu_outlined,
                      color: Color(0xFF1D5D9B),
                      size: 30,
                    ),
                    title: Text(
                      'History',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color(0xFF1D5D9B)),
                    ),
                    trailing: Icon(Icons.arrow_forward_outlined,
                        color: Color(0xFF1D5D9B), size: 30),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => history()),
                      );
                    },
                  ),

                  Divider(
                    thickness: 0.1,
                    color: Colors.grey[350],
                  ),

                  ListTile(
                    ///////////////////////////////////////////Log out
                    leading:
                        Icon(Icons.login_outlined, color: Colors.red, size: 30),
                    title: Text(
                      'Logout',
                      style: TextStyle(fontSize: 20, color: Colors.red[400]),
                    ),
                    trailing: Icon(Icons.arrow_forward_outlined,
                        color: Colors.red, size: 30),
                    onTap: () async {
                      // Show logout confirmation dialog
                      bool? confirmed =
                          await Global.showLogoutConfirmationDialog(context);
                      if (confirmed == true) {
                        // Perform logout action
                        // Add your logout logic here
                      }
                    },
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

//////////////////////////////////////////////Method for Logout warning
class Global {
  static Future<bool?> showLogoutConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFFEEFFFF),
          title: Image(
            image: AssetImage('assets/logout.png'),
          ),
          content: Text(
            "    Oh no! You're leaving \n          Are you sure?",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(false); // Cancel the logout
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Color(0xFF4497C4),
                  fontSize: 15,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Confirm the logout
              },
              child: Text(
                'OK',
                style: TextStyle(color: Colors.red, fontSize: 15),
              ),
            ),
          ],
        );
      },
    );
  }
}
