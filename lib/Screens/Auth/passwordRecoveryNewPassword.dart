// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../Constants/colors.dart';
import '../../Constants/customSizedBox.dart';
import '../../sharedWidgets/customButton.dart';
import '../../sharedWidgets/customText.dart';
import '../../sharedWidgets/customTextField.dart';
import 'defaultAuthAppbar.dart';

class PasswordRecoveryNewPassword extends StatefulWidget {
  const PasswordRecoveryNewPassword({Key? key}) : super(key: key);

  @override
  State<PasswordRecoveryNewPassword> createState() =>
      _PasswordRecoveryNewPasswordState();
}

class _PasswordRecoveryNewPasswordState
    extends State<PasswordRecoveryNewPassword> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DefaultAuthAppBar(),
          customSizedBox(0.0, 10.0),
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: CustomTxt(
                title: "تعيين كلمه سر جديدة",
                txtSize: 20,
                fontWeight: FontWeight.bold,
                color: darkenAppColor,
                ellipsis: false),
          ),
          customSizedBox(0.0, 20.0),
          CustomTextField(
            hint: "كلمه السر الجديده",
            isPassword: false,
            textEditingController: passwordController,
            keyboardType: TextInputType.emailAddress,
            icon: FontAwesomeIcons.eye,
          ),
          customSizedBox(0.0, 10.0),
          CustomTextField(
            hint: "تأكيد كلمه السر الجديده",
            isPassword: false,
            textEditingController: confirmPasswordController,
            keyboardType: TextInputType.emailAddress,
            icon: FontAwesomeIcons.eye,
          ),
          customSizedBox(0.0, 15.0),
          Center(
              child: InkWell(
            onTap: () {},
            child: CustomButton(
                widht: MediaQuery.of(context).size.width * 0.9,
                color: darkenAppColor,
                title: "تأكيد"),
          )),
        ],
      )),
    );
  }
}
