// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mirtal_doctor/Screens/offlineClendar/MyOfflineReservationCard.dart';

import '../bottomNavigation/calendarsTapBar.dart';
import 'offlineDayReservationCard.dart';

class OfflineClendar extends StatefulWidget {
  const OfflineClendar({Key? key}) : super(key: key);

  @override
  State<OfflineClendar> createState() => _OfflineClendarState();
}

class _OfflineClendarState extends State<OfflineClendar> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: customCalendarsAppbar("المواعيد الاوف لاين"),
        body: const TabBarView(
            children: [OfflineDayReservationCard(), MyOfflineReservation()]),
      ),
    );
  }
}
