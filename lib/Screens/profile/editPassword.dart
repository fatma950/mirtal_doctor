// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mirtal_doctor/Constants/customSizedBox.dart';
import 'package:mirtal_doctor/Constants/customToast.dart';
import 'package:mirtal_doctor/Constants/widthandheight.dart';
import 'package:mirtal_doctor/sharedWidgets/customTextField.dart';

import '../../Constants/colors.dart';
import '../../data/ApiRequests.dart';
import '../../sharedWidgets/customButton.dart';
import '../../sharedWidgets/customText.dart';

class EditPassword extends StatefulWidget {
  const EditPassword({Key? key}) : super(key: key);

  @override
  State<EditPassword> createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: myWhite,
        leading: BackButton(color: darkenAppColor),
        title: CustomTxt(
            color: darkenAppColor,
            ellipsis: false,
            fontWeight: FontWeight.bold,
            title: "تعديل رمز المرور",
            txtSize: 20),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            customSizedBox(0.0, getheight(context) * 0.1),
            CustomTextField(
              hint: "كلمه المرور",
              textEditingController: passwordController,
              keyboardType: TextInputType.name,
              icon: FontAwesomeIcons.lock,
              isPassword: true,
            ),
            customSizedBox(0.0, 10.0),
            CustomTextField(
              hint: " تأكيد كلمه المرور ",
              textEditingController: confirmPasswordController,
              keyboardType: TextInputType.name,
              icon: FontAwesomeIcons.lock,
              isPassword: true,
            ),
            customSizedBox(0.0, 10.0),
            InkWell(
              onTap: () {
                if (passwordController.text.isEmpty) {
                  showFailedToast("لا يمكن ان يكون حقل رمز المرور فارغ");
                  return;
                }

                if (confirmPasswordController.text.isEmpty) {
                  showFailedToast("لا يمكن ان يكون حقل تأكيد رمز المرور فارغ");
                  return;
                }
                ApiRequests().editDoctorPassword(
                    context,
                    passwordController.text.toString(),
                    confirmPasswordController.text.toString());
              },
              child: CustomButton(
                  widht: double.infinity,
                  color: appColor,
                  title: "تعديل رمز المرور"),
            )
          ],
        ),
      ),
    );
  }
}
