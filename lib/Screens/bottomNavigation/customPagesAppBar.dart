// ignore_for_file: file_names

import 'package:flutter/material.dart';

customPagesAppbar() {
  return AppBar(
    centerTitle: true,
    flexibleSpace: Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/logo7.PNG'), fit: BoxFit.fill)),
    ),
  );
}
