import 'package:finalproject/screens/home.dart';
import 'package:finalproject/screens/profile.dart';
import 'package:finalproject/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

void main() => runApp(MaterialApp(home: BottomNavBar()));

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int pageindex = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final home _home = home();
  final Setting_Page _setting = Setting_Page();
  final ProfileScreen _profile = ProfileScreen();
  Widget _showpage = new home();
  Widget _pagechosser(int page) {
    switch (page) {
      case 0:
        return _home;
        break;
      case 1:
        return _setting;
        break;
      case 2:
        return _profile;
        break;
      default:
        return new Container(
          child: Text("no page"),
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
          items: <Widget>[
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
          color: Color(0xff1D5D9B),
          buttonBackgroundColor: Color(0xffF4D160),
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
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
