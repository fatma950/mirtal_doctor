// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mirtal_doctor/Constants/colors.dart';
import 'package:mirtal_doctor/Constants/widthandheight.dart';
import 'package:mirtal_doctor/Screens/profile/usercard.dart';
import 'package:mirtal_doctor/data/ApiRequests.dart';
import 'package:mirtal_doctor/models/doctorModel.dart';
import 'package:mirtal_doctor/sharedWidgets/customButton.dart';

import '../../Constants/customSizedBox.dart';
import '../../sharedWidgets/customText.dart';
import '../bottomNavigation/customPagesAppBar.dart';

class MySettings extends StatefulWidget {
  const MySettings({Key? key}) : super(key: key);

  @override
  State<MySettings> createState() => _MySettingsState();
}

class _MySettingsState extends State<MySettings> {
  DoctorModel? doctorModel;
  bool loading = true;
  File? profilePhoto;

  @override
  void initState() {
    getDocProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myGrey.withOpacity(0.2),
      appBar: customPagesAppbar(),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
              children: [
                customSizedBox(0.0, getheight(context) * 0.1),
                Container(
                  width: 150.0,
                  height: 150.0,
                  alignment: Alignment.center,
                  child: Stack(children: [
                    Center(
                        child: profilePhoto == null
                            ? Image.network(
                                doctorModel!.photo!,
                                width: getwidth(context) * 0.4,
                                height: getheight(context) * 0.1,
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                profilePhoto!,
                                width: getwidth(context) * 0.4,
                                height: getheight(context) * 0.1,
                                fit: BoxFit.cover,
                              )),
                    IconButton(
                      icon: const Icon(Icons.camera_alt_outlined),
                      onPressed: () async {
                        final ImagePicker _profilePicker = ImagePicker();
                        final XFile? image = await _profilePicker.pickImage(
                            source: ImageSource.gallery);

                        setState(() {
                          profilePhoto = File(image!.path);
                        });
                      },
                    ),
                  ]),
                ),
                customSizedBox(0.0, 20.0),
                Center(
                    child: CustomTxt(
                  color: darkenAppColor,
                  fontWeight: FontWeight.bold,
                  title: doctorModel!.userName!,
                  txtSize: 20,
                  ellipsis: false,
                )),
                InkWell(
                  onTap: () {
                    ApiRequests().updateProfilePhoto(profilePhoto!);
                  },
                  child: CustomButton(
                      widht: getwidth(context) * 0.5,
                      color: darkenAppColor,
                      title: "Save"),
                ),
                customSizedBox(0.0, getheight(context) * 0.02),
                userCard(
                    context,
                    doctorModel!.title!,
                    doctorModel!.city!,
                    doctorModel!.region!,
                    doctorModel!.specialty!,
                    doctorModel!.location!,
                    doctorModel!.price!.toString(),
                    doctorModel!.gender!,
                    doctorModel!.birthDate!)
              ],
            )),
    );
  }

  getDocProfile() async {
    doctorModel = await ApiRequests.getUserProfile();
    setState(() {
      loading = false;
    });
  }
}
