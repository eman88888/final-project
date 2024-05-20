import 'package:finalproject/screens/home.dart';
import 'package:finalproject/screens/profile.dart';
import 'package:finalproject/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

void main() => runApp(const MaterialApp(home: BottomNavBar()));

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int pageindex = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final home _home = const home();
  final Setting_Page _setting = const Setting_Page();
  final ProfileScreen _profile = const ProfileScreen();
  Widget _showpage = const home();
  Widget _pagechosser(int page) {
    switch (page) {
      case 0:
        return _home;
        // ignore: dead_code
        break;
      case 1:
        return _setting;
        // ignore: dead_code
        break;
      case 2:
        return _profile;
        // ignore: dead_code
        break;
      default:
        // ignore: avoid_unnecessary_containers
        return Container(
          child: const Text("no page"),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: pageindex,
          height: 60.0,
          items: const <Widget>[
            Icon(
              Icons.home,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.settings,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.person,
              size: 30,
              color: Colors.white,
            ),
          ],
          backgroundColor: Colors.white,
          color: const Color(0xff1D5D9B),
          buttonBackgroundColor: const Color(0xffF4D160),
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 600),
          onTap: (int tappedindex) {
            setState(() {
              _showpage = _pagechosser(tappedindex);
            });
          },
          letIndexChange: (index) => true,
        ),
        body: Container(
          color: Colors.blueAccent,
          child: Center(child: _showpage),
        ));
  }
}
