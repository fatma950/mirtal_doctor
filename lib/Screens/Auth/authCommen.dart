// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mirtal_doctor/Constants/colors.dart';
import 'package:mirtal_doctor/Screens/Auth/passwordRecoveyEmail.dart';
import '../../Constants/customSizedBox.dart';
import '../../sharedWidgets/customText.dart';
import '../../sharedWidgets/responsiveWidget.dart';

authTextRow(
    BuildContext context, String question, String action, navigateRoute) {
  double _height = MediaQuery.of(context).size.height;
  double _width = MediaQuery.of(context).size.width;
  double _pixelRatio = MediaQuery.of(context).devicePixelRatio;
  bool _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
  bool _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

  return Container(
    margin: EdgeInsets.only(top: _height / 120.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          question,
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: _large ? 14 : (_medium ? 12 : 10)),
        ),
        customSizedBox(5.0, 0.0),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => navigateRoute));
          },
          child: Text(
            action,
            style: TextStyle(
                fontWeight: FontWeight.w800,
                color: darkenAppColor,
                fontSize: _large ? 19 : (_medium ? 17 : 15)),
          ),
        )
      ],
    ),
  );
}

Widget forgetPassTextRow(BuildContext context) {
  double _height = MediaQuery.of(context).size.height;
  double _width = MediaQuery.of(context).size.width;
  double _pixelRatio = MediaQuery.of(context).devicePixelRatio;
  bool _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
  bool _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
  return Container(
    margin: EdgeInsets.only(top: _height / 40.0),
    padding: const EdgeInsets.only(right: 15.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        CustomTxt(
            ellipsis: false,
            title: "هل نسيب كلمه المرور ؟",
            txtSize: _large ? 14 : (_medium ? 12 : 10),
            fontWeight: FontWeight.w400,
            color: Colors.black),
        customSizedBox(5.0, 0.0),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PasswordRecover()));
          },
          child: CustomTxt(
            color: darkenAppColor,
            fontWeight: FontWeight.w600,
            title: "استرجاع",
            txtSize: 15,
            ellipsis: false,
          ),
        )
      ],
    ),
  );
}
