// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../Constants/widthandheight.dart';

class DefaultAuthAppBar extends StatelessWidget {
  const DefaultAuthAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getheight(context) * 0.15,
      child: Image.asset(
        "assets/logo7.PNG",
        fit: BoxFit.fill,
      ),
    );
  }
}
