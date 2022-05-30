// ignore_for_file: file_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mirtal_doctor/Constants/myNavigator.dart';

import '../../Constants/colors.dart';
import '../../Constants/widthandheight.dart';
import '../Auth/login.dart';

class MySplash extends StatefulWidget {
  const MySplash({Key? key}) : super(key: key);

  @override
  State<MySplash> createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      MyNavigetor().push(const LoginPage(), context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: myBlack,
        body: Stack(
          children: [
            Container(
                decoration: BoxDecoration(color: myBlack),
                child: Center(
                    child: Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/Capture2.JPG',
                              height: getwidth(context) / 2,

                              //color: appColor1,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        )))),
          ],
        ));
  }
}
