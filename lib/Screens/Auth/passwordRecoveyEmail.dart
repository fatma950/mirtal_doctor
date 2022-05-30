// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mirtal_doctor/Constants/colors.dart';
import 'package:mirtal_doctor/Constants/customToast.dart';
import 'package:mirtal_doctor/Screens/Auth/defaultAuthAppbar.dart';
import 'package:mirtal_doctor/data/ApiRequests.dart';
import 'package:mirtal_doctor/sharedWidgets/customText.dart';

import '../../Constants/customSizedBox.dart';
import '../../sharedWidgets/customButton.dart';
import '../../sharedWidgets/customTextField.dart';

class PasswordRecover extends StatefulWidget {
  const PasswordRecover({Key? key}) : super(key: key);

  @override
  State<PasswordRecover> createState() => _PasswordRecoverState();
}

class _PasswordRecoverState extends State<PasswordRecover> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DefaultAuthAppBar(),
          customSizedBox(0.0, 15.0),
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: CustomTxt(
                title: "هل نسيت كلمه المرور ؟",
                txtSize: 20,
                fontWeight: FontWeight.bold,
                color: darkenAppColor,
                ellipsis: false),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: CustomTxt(
                title:
                    "يرجى ارسال البريد الالكترونى الخاص بك وسنرسل رابط لاعاده تعيين كلمه المرور ... ",
                txtSize: 15.0,
                fontWeight: FontWeight.normal,
                color: myBlack,
                ellipsis: false),
          ),
          customSizedBox(0.0, 20.0),
          CustomTextField(
            hint: "البريد الالكترونى",
            isPassword: false,
            textEditingController: emailController,
            keyboardType: TextInputType.emailAddress,
            icon: FontAwesomeIcons.envelope,
          ),
          customSizedBox(0.0, 20.0),
          Center(
              child: InkWell(
            onTap: () {
              if (emailController.text.isEmpty) {
                showFailedToast("برجاء ادحال البريد الالكترونى");
              }
              ApiRequests()
                  .passwordRecovery(context, emailController.text.toString());
            },
            child: CustomButton(
                widht: MediaQuery.of(context).size.width * 0.9,
                color: darkenAppColor,
                title: "ارسال"),
          )),
        ],
      )),
    );
  }
}
