// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mirtal_doctor/Constants/colors.dart';

import '../../sharedWidgets/customText.dart';

Widget userCard(
  BuildContext context,
  String title,
  String city,
  String region,
  String specialty,
  String location,
  String price,
  String gender,
  String birthDate,
) {
  return Container(
      padding: const EdgeInsets.all(10),
      child: Card(
        color: Colors.white,
        child: Container(
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: <Widget>[
                  listTile("المدينه", city, Icons.location_city),
                  listTile("المنطقه", region, Icons.location_on),
                  listTile(
                      "التخصص", specialty, Icons.supervised_user_circle_sharp),
                  listTile("وصف التخصص", title, Icons.swipe_vertical),
                  listTile("الموقع", location, Icons.location_pin),
                  listTile("السعر", price, Icons.price_change),
                  listTile("النوع", gender, Icons.manage_accounts),
                  listTile("تاريخ الميلاد", birthDate, Icons.date_range),
                ],
              )
            ],
          ),
        ),
      ));
}

Widget listTile(String title, String subTitle, IconData icon) {
  return Column(
    children: [
      ListTile(
        leading: Icon(icon, color: darkenAppColor),
        title: CustomTxt(
          title: title,
          color: darkenAppColor,
          fontWeight: FontWeight.bold,
          txtSize: 15,
          ellipsis: false,
        ),
        subtitle: CustomTxt(
          title: subTitle,
          color: appColor,
          fontWeight: FontWeight.normal,
          txtSize: 12,
          ellipsis: false,
        ),
      ),
      const Divider(),
    ],
  );
}
