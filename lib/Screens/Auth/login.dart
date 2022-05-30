// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mirtal_doctor/Constants/colors.dart';
import 'package:mirtal_doctor/Constants/customToast.dart';
import 'package:mirtal_doctor/Constants/widthandheight.dart';
import 'package:mirtal_doctor/Screens/Auth/defaultAuthAppbar.dart';
import 'package:mirtal_doctor/data/ApiRequests.dart';

import '../../Constants/customSizedBox.dart';
import '../../sharedWidgets/customButton.dart';
import '../../sharedWidgets/customText.dart';
import '../../sharedWidgets/customTextField.dart';
import '../../sharedWidgets/responsiveWidget.dart';
import 'authCommen.dart';
import 'register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    double _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    bool _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    bool _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DefaultAuthAppBar(),
              Container(
                margin: EdgeInsets.only(left: _width / 20, top: _height / 100),
                padding: const EdgeInsets.only(right: 15.0),
                child: CustomTxt(
                    title: "تسجيل الدخول",
                    ellipsis: false,
                    txtSize: _large ? 50 : (_medium ? 40 : 30),
                    fontWeight: FontWeight.bold,
                    color: darkenAppColor),
              ),
              Container(
                margin: EdgeInsets.only(left: _width / 15.0),
                padding: const EdgeInsets.only(right: 15.0),
                child: CustomTxt(
                  title: "سجل دخول بحساب العمل الخاص بك",
                  txtSize: _large ? 20 : (_medium ? 17.5 : 15),
                  fontWeight: FontWeight.normal,
                  color: appColor,
                  ellipsis: false,
                ),
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
              CustomTextField(
                hint: "كلمه المرور",
                textEditingController: passwordController,
                keyboardType: TextInputType.name,
                icon: FontAwesomeIcons.lock,
                isPassword: true,
              ),
              forgetPassTextRow(context),
              customSizedBox(0.0, MediaQuery.of(context).size.height / 50),
              Center(
                  child: InkWell(
                onTap: () {
                  if (passwordController.text.isEmpty) {
                    showFailedToast("من فضلك قم بادخال رمز المرور");
                    return;
                  }
                  if (emailController.text.isEmpty) {
                    showFailedToast("من فضلك قم بادخال البريد الالكترونى ");
                    return;
                  }
                  setState(() {
                    ApiRequests().loginDoctor(emailController.text.toString(),
                        passwordController.text.toString(), context);
                  });
                },
                child: CustomButton(
                    widht: MediaQuery.of(context).size.width * 0.9,
                    color: darkenAppColor,
                    title: "دخول"),
              )),
              customSizedBox(0.0, getheight(context) * 0.4),
              authTextRow(context, "ليس لديك حساب ؟", "تسجيل الدخول ",
                  const Registration()),
            ],
          ),
        ),
      ),
    );
  }
}
