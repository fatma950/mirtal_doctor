// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mirtal_doctor/Constants/colors.dart';
import 'package:mirtal_doctor/Screens/bottomNavigation/calendarsTapBar.dart';
import 'package:mirtal_doctor/Screens/onlineClendar/MyReservationCard.dart';
import 'package:mirtal_doctor/Screens/onlineClendar/dayReservationCard.dart';

class OnlineClendar extends StatefulWidget {
  const OnlineClendar({Key? key}) : super(key: key);

  @override
  State<OnlineClendar> createState() => _OnlineClendarState();
}

class _OnlineClendarState extends State<OnlineClendar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: myGrey.withOpacity(0.2),
        appBar: customCalendarsAppbar("المواعيد الاون لاين"),
        body:
            const TabBarView(children: [DayReservationCard(), MyReservation()]),
      ),
    );
  }
}
