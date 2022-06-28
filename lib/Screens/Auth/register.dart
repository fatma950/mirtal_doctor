// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mirtal_doctor/Constants/colors.dart';
import 'package:mirtal_doctor/Constants/strings.dart';
import 'package:mirtal_doctor/Screens/Auth/defaultAuthAppbar.dart';
import 'package:mirtal_doctor/data/ApiRequests.dart';
import '../../Constants/customSizedBox.dart';
import '../../Constants/widthandheight.dart';
import '../../sharedWidgets/customButton.dart';
import '../../sharedWidgets/customText.dart';
import '../../sharedWidgets/customTextField.dart';
import '../../sharedWidgets/responsiveWidget.dart';
import 'authCommen.dart';
import 'login.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';

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
  TextEditingController cityController = TextEditingController();
  TextEditingController regionController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController specialityController = TextEditingController();
  TextEditingController specialityDescriptionController =
      TextEditingController();

  String birthDateInString = "";
  DateTime birthDate = DateTime.now();
  bool isDateSelected = false;

  File? profileImage;
  File? licenceImage;

  String genderTxt = "";

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
                                  ? DateTime.now().toString()
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
                          "${birthDate.month}/${birthDate.day}/${birthDate.year}";
                    });
                  }
                }),
            customSizedBox(0.0, 10.0),
            GenderPickerWithImage(
              showOtherGender: true,
              verticalAlignedText: false,
              selectedGender: Gender.Male,
              selectedGenderTextStyle:
                  TextStyle(color: darkenAppColor, fontWeight: FontWeight.bold),
              unSelectedGenderTextStyle:
                  TextStyle(color: myWhite, fontWeight: FontWeight.normal),
              onChanged: (gender) {
                setState(() {
                  genderTxt = gender.toString();
                });
              },
              equallyAligned: true,
              animationDuration: const Duration(milliseconds: 300),
              isCircular: true,
              // default : true,
              opacityOfGradient: 0.4,
              padding: const EdgeInsets.all(3),
              size: 50, //default : 40
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
            CustomTextField(
              hint: "المنطقه",
              textEditingController: regionController,
              keyboardType: TextInputType.name,
              icon: Icons.location_on_outlined,
              isPassword: false,
            ),
            customSizedBox(0.0, 10.0),
            CustomTextField(
              hint: "عنوان العياده",
              textEditingController: addressController,
              keyboardType: TextInputType.name,
              icon: Icons.location_city,
              isPassword: false,
            ),
            customSizedBox(0.0, 10.0),
            CustomTextField(
              hint: "التخصص",
              textEditingController: specialityController,
              keyboardType: TextInputType.name,
              icon: Icons.swipe_vertical,
              isPassword: false,
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
              keyboardType: TextInputType.name,
              icon: Icons.monetization_on,
              isPassword: false,
            ),
            customSizedBox(0.0, 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Stack(children: [
                  Center(
                      child: profileImage == null
                          ? Image.network(
                              imagePlaceHolder,
                              width: getwidth(context) * 0.4,
                              height: getheight(context) * 0.1,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              profileImage!,
                              width: getwidth(context) * 0.4,
                              height: getheight(context) * 0.1,
                              fit: BoxFit.cover,
                            )),
                  Positioned(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () async {
                            final ImagePicker _profilePicker = ImagePicker();
                            final XFile? image = await _profilePicker.pickImage(
                              source: ImageSource.gallery,
                            );

                            setState(() {
                              profileImage = File(image!.path);
                            });
                          },
                          icon: const Icon(
                            FontAwesomeIcons.camera,
                            size: 30,
                            color: Colors.white,
                          )),
                    ),
                  ),
                  Positioned(
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        alignment: Alignment.bottomCenter,
                        child: const Text("اختر صورة البروفايل")),
                  )
                ]),
                Stack(children: [
                  Center(
                      child: licenceImage == null
                          ? Image.network(
                              imagePlaceHolder,
                              width: getwidth(context) * 0.4,
                              height: getheight(context) * 0.1,
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              licenceImage!,
                              width: getwidth(context) * 0.4,
                              height: getheight(context) * 0.1,
                              fit: BoxFit.cover,
                            )),
                  Positioned(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () async {
                            final ImagePicker licencePicker = ImagePicker();

                            final XFile? image = await licencePicker.pickImage(
                              source: ImageSource.gallery,
                            );

                            setState(() {
                              licenceImage = File(image!.path);
                            });
                          },
                          icon: const Icon(
                            FontAwesomeIcons.camera,
                            size: 30,
                            color: Colors.white,
                          )),
                    ),
                  ),
                  Positioned(
                    child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        alignment: Alignment.bottomCenter,
                        child: const Text("اختر صورة الرخصة")),
                  )
                ]),
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
                      cityController.text.toString(),
                      birthDateInString,
                      priceController.text.toString(),
                      specialityDescriptionController.text.toString(),
                      specialityController.text.toString(),
                      locationController.text.toString(),
                      genderTxt,
                      regionController.text.toString(),
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
