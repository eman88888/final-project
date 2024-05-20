import 'package:finalproject/pages/history.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _username = '';
  String _email = '';
  String _job = '';
  String _country = '';
  String _phone = '';
  /////////
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoading = false;
  //////////////
  @override
  void initState() {
    super.initState();
    // Call a function to fetch user data
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    // Get the currently authenticated user

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Retrieve the document with the user's ID
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      // Check if the document exists
      if (documentSnapshot.exists) {
        // Get user data from the document
        Map<String, dynamic> userData =
            documentSnapshot.data() as Map<String, dynamic>;

        setState(() {
          _username = userData['name'] ?? '';
          _email = userData['email'] ?? '';
          _job = userData['job'] ?? '';
          _country = userData['country'] ?? '';
          _phone = userData['phone'] ?? '';
          isLoading = false;
        });
      }
    }
  }

  /////////////////////////
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
                    color: const Color(0xFF1D5D9B),
                    child: Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              left: 120, right: 120, top: 80),
                          child: const CircleAvatar(
                            radius: 90,
                            backgroundImage: AssetImage("assets/profile.png"),
                          ),
                        ),
                        Positioned(
                          bottom: 80,
                          left: 0,
                          right: 0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              /////// Display name and text Researcher
                              Text(
                                _username,
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontFamily: 'Pacifico',
                                  color: Colors.white,
                                ),
                              ),
                              const Padding(
                                  padding: EdgeInsets.only(bottom: 10)),
                              const Text(
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
                    offset: const Offset(0, 2), // Offset
                  ),
                ],
                color: Colors.white,
                borderRadius: const BorderRadius.only(
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
                    leading: const Icon(
                      Icons.person_outline_outlined,
                      color: Color(0xFF1D5D9B),
                      size: 30,
                    ),
                    title: Text(
                      _username,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        //fontWeight: FontWeight.bold
                      ),
                    ),
                  ),

                  const Divider(
                    thickness: 0.6,
                    color: Colors.grey,
                  ),

                  ListTile(
                    ///////////////////////////////////////////Email
                    leading: const Icon(Icons.email_outlined,
                        color: Color(0xFF1D5D9B), size: 30),
                    title: Text(
                      _email,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        //fontWeight: FontWeight.bold
                      ),
                    ),
                  ),

                  const Divider(
                    thickness: 0.6,
                    color: Colors.grey,
                  ),

                  ListTile(
                    ///////////////////////////////////////////Job
                    leading: const Icon(Icons.work_outline_outlined,
                        color: Color(0xFF1D5D9B), size: 30),
                    title: Text(
                      _job,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        //fontWeight: FontWeight.bold
                      ),
                    ),
                  ),

                  const Divider(
                    thickness: 0.6,
                    color: Colors.grey,
                  ),

                  ListTile(
                    ///////////////////////////////////////////Country
                    leading: const Icon(Icons.location_on_outlined,
                        color: Color(0xFF1D5D9B), size: 30),
                    title: Text(
                      _country,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        //fontWeight: FontWeight.bold
                      ),
                    ),
                  ),

                  const Divider(
                    thickness: 0.6,
                    color: Colors.grey,
                  ),

                  ListTile(
                    ///////////////////////////////////////////Mobile
                    leading: const Icon(Icons.phone_enabled_outlined,
                        color: Color(0xFF1D5D9B), size: 30),
                    title: Text(
                      _phone,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        //fontWeight: FontWeight.bold
                      ),
                    ),
                  ),

                  const Divider(
                    thickness: 0.6,
                    color: Colors.grey,
                  ),

                  ListTile(
                    ///////////////////////////////////////////History
                    leading: const Icon(
                      Icons.history_edu_outlined,
                      color: Color(0xFF1D5D9B),
                      size: 30,
                    ),
                    title: const Text(
                      'History',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color(0xFF1D5D9B)),
                    ),
                    trailing: const Icon(Icons.arrow_forward_outlined,
                        color: Color(0xFF1D5D9B), size: 30),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const history()),
                      );
                    },
                  ),

                  const Divider(
                    thickness: 0.6,
                    color: Colors.grey,
                  ),

                  ListTile(
                    ///////////////////////////////////////////Log out
                    leading: const Icon(Icons.login_outlined,
                        color: Colors.red, size: 30),
                    title: Text(
                      'Logout',
                      style: TextStyle(fontSize: 20, color: Colors.red[400]),
                    ),
                    trailing: const Icon(Icons.arrow_forward_outlined,
                        color: Colors.red, size: 30),
                    onTap: () async {
                      // Show logout confirmation dialog
                      bool? confirmed =
                          await Global.showLogoutConfirmationDialog(context);
                      if (confirmed == true) {
                        // Perform logout action
                        // Add your logout logic here
                        await _auth.signOut();
                        Navigator.pushNamedAndRemoveUntil(
                            // ignore: use_build_context_synchronously
                            context,
                            '/',
                            (route) => false);
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
          backgroundColor: const Color(0xFFEEFFFF),
          title: const Image(
            image: AssetImage('assets/logout.png'),
          ),
          content: const Text(
            "    Oh no! You're leaving \n          Are you sure?",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop(false); // Cancel the logout
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Color(0xFF4497C4),
                  fontSize: 15,
                ),
              ),
            ),
            TextButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop(true); // Confirm the logout
              },
              child: const Text(
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
