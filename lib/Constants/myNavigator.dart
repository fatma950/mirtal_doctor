// ignore_for_file: file_names

import 'package:flutter/material.dart';

class MyNavigetor {
  push(screenName, BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => screenName));
  }
}
