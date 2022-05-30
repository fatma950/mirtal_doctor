// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomTxt extends StatelessWidget {
  final String title;
  final double txtSize;
  final FontWeight fontWeight;
  final Color color;
  final bool ellipsis;

  const CustomTxt({
    Key? key,
    required this.title,
    required this.txtSize,
    required this.fontWeight,
    required this.color,
    required this.ellipsis,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: TextStyle(
            color: color,
            fontSize: txtSize,
            overflow: ellipsis ? TextOverflow.ellipsis : TextOverflow.visible,
            fontWeight: fontWeight,
            fontFamily: 'Cairo'));
  }
}
