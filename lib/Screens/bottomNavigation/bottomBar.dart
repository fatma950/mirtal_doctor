// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mirtal_doctor/Constants/colors.dart';
import 'package:mirtal_doctor/Screens/home/homeScreen.dart';
import 'package:mirtal_doctor/Screens/offlineClendar/offlineClendar.dart';
import 'package:mirtal_doctor/Screens/onlineClendar/onlineClendar.dart';
import 'package:mirtal_doctor/Screens/profile/mySettings.dart';

import 'customBottomNavigationBar.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: darkenAppColor,
        currentIndex: _selectedIndex,
        unselectedItemColor: myGrey,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          custombottomNavBar("الرئيسية", Icons.home),
          custombottomNavBar(
              "المواعيد الاون لاين", Icons.calendar_month_rounded),
          custombottomNavBar("المواعيد الاوف لاين", Icons.calendar_today),
          custombottomNavBar("الصفحه الشخصيه", Icons.settings),
        ],
      ),
      body: Center(child: _pages.elementAt(_selectedIndex)),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _pages = <Widget>[
    HomeScreen(),
    OnlineClendar(),
    OfflineClendar(),
    MySettings(),
  ];
}
