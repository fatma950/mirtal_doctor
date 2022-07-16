// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'package:mirtal_doctor/Constants/colors.dart';

import '../../Constants/customSizedBox.dart';
import '../../sharedWidgets/customText.dart';

class MyComment extends StatelessWidget {
  final String profilePhotoUrl;
  final String doctorName;
  final String speciality;
  final String time;
  final String comment;
  const MyComment({
    Key? key,
    required this.profilePhotoUrl,
    required this.doctorName,
    required this.speciality,
    required this.time,
    required this.comment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          color: myWhite, borderRadius: BorderRadius.circular(10.0)),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(40.0),
            child: Image.network(
              profilePhotoUrl,
              width: 50.0,
              height: 50.0,
            ),
          ),
          customSizedBox(10.0, 0.0),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTxt(
                    title: doctorName + " ($speciality)",
                    txtSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: darkenAppColor,
                    ellipsis: false),
                CustomTxt(
                    title: time,
                    txtSize: 12,
                    fontWeight: FontWeight.normal,
                    color: myGrey,
                    ellipsis: false),
                customSizedBox(0.0, 10.0),
                CustomTxt(
                    title: comment,
                    txtSize: 14,
                    fontWeight: FontWeight.bold,
                    color: myBlack,
                    ellipsis: true),
              ],
            ),
          )
        ],
      ),
    );
  }
}
