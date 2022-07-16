// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:mirtal_doctor/Constants/colors.dart';
import 'package:mirtal_doctor/Constants/strings.dart';
import 'package:mirtal_doctor/Screens/Auth/defaultAuthAppbar.dart';
import 'package:mirtal_doctor/data/ApiRequests.dart';
import 'package:mirtal_doctor/data/cities.dart';
import 'package:mirtal_doctor/data/regions.dart';
import 'package:mirtal_doctor/data/specialities.dart';
import '../../Constants/customSizedBox.dart';
import '../../Constants/widthandheight.dart';
import '../../sharedWidgets/customButton.dart';
import '../../sharedWidgets/customText.dart';
import '../../sharedWidgets/customTextField.dart';
import '../../sharedWidgets/responsiveWidget.dart';
import 'authCommen.dart';
import 'login.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  TextEditingController addressController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  TextEditingController specialityDescriptionController =
      TextEditingController();

  String birthDateInString = "";
  DateTime birthDate = DateTime.now();
  bool isDateSelected = false;

  File? profileImage;
  File? licenceImage;

  String? genderTxt;
  String? city;
  String? speciality;
  String? region;

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    double _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    bool _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    bool _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return Scaffold(
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
                  title: "انشاء حساب جديد",
                  txtSize: _large ? 60 : (_medium ? 50 : 40),
                  fontWeight: FontWeight.bold,
                  ellipsis: false,
                  color: darkenAppColor),
            ),
            customSizedBox(0.0, 10.0),
            CustomTextField(
              hint: "اسم المستخدم",
              isPassword: false,
              textEditingController: nameController,
              keyboardType: TextInputType.name,
              icon: Icons.man,
            ),
            customSizedBox(0.0, 10.0),
            CustomTextField(
              hint: "البريد الالكترونى",
              textEditingController: emailController,
              keyboardType: TextInputType.emailAddress,
              icon: Icons.email,
              isPassword: false,
            ),
            customSizedBox(0.0, 10.0),
            CustomTextField(
              hint: "رمز المرور",
              textEditingController: passwordController,
              keyboardType: TextInputType.name,
              icon: Icons.lock,
              isPassword: true,
            ),
            customSizedBox(0.0, 10.0),
            CustomTextField(
              hint: "تاكيد رمز المرور",
              textEditingController: confirmController,
              keyboardType: TextInputType.name,
              icon: Icons.lock,
              isPassword: true,
            ),
            customSizedBox(0.0, 10.0),
            CustomTextField(
              hint: "رقم الهاتف",
              textEditingController: phoneController,
              keyboardType: TextInputType.name,
              icon: Icons.phone,
              isPassword: false,
            ),
            customSizedBox(0.0, 10.0),
            GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border: Border.all(color: myGrey),
                          borderRadius: BorderRadius.circular(10.0),
                          color: myWhite),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomTxt(
                              title: birthDateInString == ""
                                  ? DateFormat("yyyy-MM-dd")
                                      .format(DateTime.now())
                                  : birthDateInString,
                              txtSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: myBlack,
                              ellipsis: false),
                          Icon(
                            Icons.calendar_month,
                            color: darkenAppColor,
                          ),
                        ],
                      )),
                ),
                onTap: () async {
                  final datePick = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime(2100));
                  if (datePick != null && datePick != birthDate) {
                    setState(() {
                      birthDate = datePick;
                      isDateSelected = true;

                      birthDateInString =
                          "${birthDate.day}-${birthDate.month}-${birthDate.year}";
                    });
                  }
                }),
            customSizedBox(0.0, 10.0),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(right: 10, left: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0)),
                child: DropdownButton<String>(
                  underline: Container(),
                  style: TextStyle(
                      color: darkenAppColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                  hint: const Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Text("من فضلك اختر النوع",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.normal)),
                  ),
                  isExpanded: true,
                  items: ["male", "female"].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  value: genderTxt,
                  onChanged: (newValue) {
                    setState(() {
                      genderTxt = newValue;
                    });
                  },
                ),
              ),
            ),
            customSizedBox(0.0, 10.0),
            CustomTextField(
              hint: "الموقع",
              textEditingController: locationController,
              keyboardType: TextInputType.name,
              icon: Icons.location_on,
              isPassword: false,
            ),
            customSizedBox(0.0, 10.0),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(right: 10, left: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0)),
                child: DropdownButton<String>(
                  underline: Container(),
                  style: TextStyle(
                      color: darkenAppColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                  hint: const Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Text("من فضلك اختر المنطقه",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.normal)),
                  ),
                  isExpanded: true,
                  items: regions.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  value: region,
                  onChanged: (newValue) {
                    setState(() {
                      region = newValue;
                    });
                  },
                ),
              ),
            ),
            customSizedBox(0.0, 10.0),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(right: 10, left: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0)),
                child: DropdownButton<String>(
                  underline: Container(),
                  style: TextStyle(
                      color: darkenAppColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                  hint: const Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Text("من فضلك اختر العنوان",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.normal)),
                  ),
                  isExpanded: true,
                  items: cities.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  value: city,
                  onChanged: (newValue) {
                    setState(() {
                      city = newValue;
                    });
                  },
                ),
              ),
            ),
            customSizedBox(0.0, 10.0),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(right: 10, left: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10.0)),
                child: DropdownButton<String>(
                  underline: Container(),
                  style: TextStyle(
                      color: darkenAppColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                  hint: const Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Text("من فضلك اختر التخصص",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.normal)),
                  ),
                  isExpanded: true,
                  items: specialities.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  value: speciality,
                  onChanged: (newValue) {
                    setState(() {
                      speciality = newValue;
                    });
                  },
                ),
              ),
            ),
            customSizedBox(0.0, 10.0),
            CustomTextField(
              hint: "وصف التخصص",
              textEditingController: specialityDescriptionController,
              keyboardType: TextInputType.name,
              icon: Icons.swipe_vertical_outlined,
              isPassword: false,
            ),
            customSizedBox(0.0, 10.0),
            CustomTextField(
              hint: "سعر الكشف",
              textEditingController: priceController,
              keyboardType: TextInputType.number,
              icon: Icons.monetization_on,
              isPassword: false,
            ),
            customSizedBox(0.0, 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                    width: getwidth(context) * 0.4,
                    child: Column(
                      children: [
                        Stack(children: [
                          Center(
                              child: profileImage == null
                                  ? Image.asset(
                                      imagePlaceHolder,
                                      width: getwidth(context) * 0.3,
                                      height: getheight(context) * 0.1,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
                                      profileImage!,
                                      width: getwidth(context) * 0.3,
                                      height: getheight(context) * 0.1,
                                      fit: BoxFit.cover,
                                    )),
                          Positioned(
                              child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 20),
                            alignment: Alignment.center,
                            child: InkWell(
                                onTap: () async {
                                  final ImagePicker _profilePicker =
                                      ImagePicker();
                                  final XFile? image =
                                      await _profilePicker.pickImage(
                                    source: ImageSource.gallery,
                                  );

                                  setState(() {
                                    profileImage = File(image!.path);
                                  });
                                },
                                child: Image.asset(imagePlaceHolderIcon,
                                    width: 50, height: 50)),
                          ))
                        ]),
                        customSizedBox(0.0, 10.0),
                        Center(
                            child: CustomTxt(
                                title: "اختر صورة البروفايل",
                                txtSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: darkenAppColor,
                                ellipsis: false))
                      ],
                    )),
                SizedBox(
                    width: getwidth(context) * 0.4,
                    child: Column(
                      children: [
                        Stack(children: [
                          Center(
                              child: licenceImage == null
                                  ? Image.asset(
                                      imagePlaceHolder,
                                      width: getwidth(context) * 0.3,
                                      height: getheight(context) * 0.1,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
                                      licenceImage!,
                                      width: getwidth(context) * 0.3,
                                      height: getheight(context) * 0.1,
                                      fit: BoxFit.cover,
                                    )),
                          Positioned(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 20),
                              alignment: Alignment.center,
                              child: InkWell(
                                  onTap: () async {
                                    final ImagePicker licencePicker =
                                        ImagePicker();

                                    final XFile? image =
                                        await licencePicker.pickImage(
                                      source: ImageSource.gallery,
                                    );

                                    setState(() {
                                      licenceImage = File(image!.path);
                                    });
                                  },
                                  child: Image.asset(imagePlaceHolderIcon,
                                      width: 50, height: 50)),
                            ),
                          ),
                        ]),
                        customSizedBox(0.0, 10.0),
                        Center(
                            child: CustomTxt(
                                title: "اختر صورة الرخصه",
                                txtSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: darkenAppColor,
                                ellipsis: false))
                      ],
                    ))
              ],
            ),
            customSizedBox(0.0, 20.0),
            InkWell(
              onTap: () {
                setState(() {
                  ApiRequests().signUpDoctor(
                      context,
                      emailController.text.toString(),
                      passwordController.text.toString(),
                      confirmController.text.toString(),
                      phoneController.text.toString(),
                      nameController.text.toString(),
                      city!,
                      birthDateInString,
                      priceController.text.toString(),
                      specialityDescriptionController.text.toString(),
                      speciality!,
                      locationController.text.toString(),
                      genderTxt!,
                      region!,
                      licenceImage!,
                      profileImage!);
                });
              },
              child: Center(
                  child: CustomButton(
                      widht: getwidth(context) * 0.8,
                      color: darkenAppColor,
                      title: "سجل الان")),
            ),
            authTextRow(context, "هل لديك حساب بالفعل ؟", "ادخل الان ..",
                const LoginPage()),
          ],
        ),
      ),
    );
  }
}
