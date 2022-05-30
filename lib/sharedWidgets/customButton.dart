// ignore_for_file: file_names

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double widht;
  final Color color;
  final String title;
  const CustomButton({
    Key? key,
    required this.widht,
    required this.color,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(3),
      width: widht,
      height: 50,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(10)),
      child: Center(
          child: Text(
        title,
        style: const TextStyle(
            fontSize: 15.0, fontWeight: FontWeight.bold, color: Colors.white),
      )),
    );
  }
}
