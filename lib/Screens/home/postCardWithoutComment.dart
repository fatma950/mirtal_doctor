// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'package:mirtal_doctor/Constants/colors.dart';
import 'package:mirtal_doctor/Constants/customSizedBox.dart';
import 'package:mirtal_doctor/sharedWidgets/customText.dart';

class MyPostsWithoutComment extends StatefulWidget {
  final String patientName;
  final String description;
  final String speciality;
  final String date;
  final String postID;
  const MyPostsWithoutComment({
    Key? key,
    required this.patientName,
    required this.description,
    required this.speciality,
    required this.date,
    required this.postID,
  }) : super(key: key);

  @override
  State<MyPostsWithoutComment> createState() => _MyPostsWithoutCommentState();
}

class _MyPostsWithoutCommentState extends State<MyPostsWithoutComment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          color: myWhite, borderRadius: BorderRadius.circular(15.0)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CustomTxt(
            title: widget.patientName,
            txtSize: 15.0,
            fontWeight: FontWeight.bold,
            color: darkenAppColor,
            ellipsis: false),
        CustomTxt(
            title: widget.date,
            txtSize: 12,
            fontWeight: FontWeight.normal,
            color: myGrey,
            ellipsis: false),
        customSizedBox(0.0, 10.0),
        CustomTxt(
            title: widget.description,
            txtSize: 13.0,
            fontWeight: FontWeight.normal,
            color: myBlack,
            ellipsis: false),
        customSizedBox(0.0, 15.0),
        CustomTxt(
            title: "التخصص : " + widget.speciality,
            txtSize: 15.0,
            fontWeight: FontWeight.bold,
            color: darkenAppColor,
            ellipsis: false),
      ]),
    );
  }
}
