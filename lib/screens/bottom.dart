import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import 'home.dart';

class BottomScreen extends StatefulWidget {
  const BottomScreen({Key? key}) : super(key: key);

  static const routeName = "/bottom";

  @override
  State<BottomScreen> createState() => _BottomScreenState();
}

class _BottomScreenState extends State<BottomScreen> {
  int _activeTabs = 0;

  static  final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    Container(),
    Container(),
    Container(),
    Container(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_activeTabs),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xff152238),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        currentIndex: _activeTabs,
        onTap: (tab) {
          setState(() {
            _activeTabs = tab;
          });
        },
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Color(0xff152238),
            icon: Icon(CupertinoIcons.home),
            label: "Home",
            activeIcon: Icon(CupertinoIcons.house_fill),
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xff152238),
            icon: Icon(Ionicons.rocket_outline),
            label: "Challenges",
            activeIcon: Icon(Ionicons.rocket),
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xff152238),
            icon: Icon(CupertinoIcons.gift),
            label: "Rewards",
            activeIcon: Icon(CupertinoIcons.gift_fill),
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xff152238),
            icon: Icon(CupertinoIcons.person),
            label: "Profile",
            activeIcon: Icon(CupertinoIcons.person_alt),
          ),
        ],
      ),
    );
  }
}
