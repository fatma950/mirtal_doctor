// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mirtal_doctor/Constants/colors.dart';
import 'package:mirtal_doctor/sharedWidgets/customText.dart';

customCalendarsAppbar(String title) {
  return AppBar(
    centerTitle: true,
    backgroundColor: darkenAppColor,
    title: Text(title),
    bottom: TabBar(tabs: [
      CustomTxt(
          title: "المواعيد المتاحه",
          txtSize: 15.0,
          fontWeight: FontWeight.bold,
          color: myWhite,
          ellipsis: false),
      CustomTxt(
          title: "الحجوزات",
          txtSize: 15.0,
          fontWeight: FontWeight.bold,
          color: myWhite,
          ellipsis: false),
    ]),
  );
}
