// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:mirtal_doctor/Constants/colors.dart';
import 'package:mirtal_doctor/Constants/customSizedBox.dart';
import 'package:mirtal_doctor/models/doctorModel.dart';
import 'package:mirtal_doctor/sharedWidgets/customButton.dart';
import 'package:mirtal_doctor/sharedWidgets/customText.dart';

import '../../Constants/widthandheight.dart';
import '../../data/ApiRequests.dart';

class EditProfilePhoto extends StatefulWidget {
  final DoctorModel doctorModel;
  const EditProfilePhoto({
    Key? key,
    required this.doctorModel,
  }) : super(key: key);

  @override
  State<EditProfilePhoto> createState() => _EditProfilePhotoState();
}

class _EditProfilePhotoState extends State<EditProfilePhoto> {
  File? profilePhoto;

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
            title: "تعديل الصوره",
            txtSize: 20),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            customSizedBox(0.0, getheight(context) * 0.1),
            Center(
                child: profilePhoto == null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: Image.network(
                          widget.doctorModel.photo!,
                          width: getwidth(context) * 0.4,
                          height: getheight(context) * 0.1,
                          fit: BoxFit.fill,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: Image.file(
                          profilePhoto!,
                          width: getwidth(context) * 0.4,
                          height: getheight(context) * 0.1,
                          fit: BoxFit.cover,
                        ),
                      )),
            customSizedBox(0.0, 20.0),
            InkWell(
              onTap: () async {
                final ImagePicker _profilePicker = ImagePicker();
                final XFile? image =
                    await _profilePicker.pickImage(source: ImageSource.gallery);

                setState(() {
                  profilePhoto = File(image!.path);
                });
              },
              child: CustomButton(
                  widht: double.infinity,
                  color: appColor,
                  title: "اختيار صوره"),
            ),
            customSizedBox(0.0, 10.0),
            InkWell(
              onTap: () {
                ApiRequests().updateProfilePhoto(profilePhoto!);
              },
              child: CustomButton(
                  widht: double.infinity, color: appColor, title: "تحميل صوره"),
            )
          ],
        ),
      ),
    );
  }
}
