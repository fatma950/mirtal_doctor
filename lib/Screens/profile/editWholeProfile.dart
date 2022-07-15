// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:mirtal_doctor/models/doctorModel.dart';

import '../../Constants/colors.dart';
import '../../Constants/customSizedBox.dart';
import '../../Constants/widthandheight.dart';
import '../../data/ApiRequests.dart';
import '../../data/cities.dart';
import '../../data/specialities.dart';
import '../../sharedWidgets/customButton.dart';
import '../../sharedWidgets/customText.dart';
import '../../sharedWidgets/customTextField.dart';

class EditWholeProfile extends StatefulWidget {
  final DoctorModel doctorModel;
  const EditWholeProfile({
    Key? key,
    required this.doctorModel,
  }) : super(key: key);

  @override
  State<EditWholeProfile> createState() => _EditWholeProfileState();
}

class _EditWholeProfileState extends State<EditWholeProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  TextEditingController regionController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  TextEditingController specialityDescriptionController =
      TextEditingController();

  String birthDateInString = "";
  DateTime birthDate = DateTime.now();
  bool isDateSelected = false;

  String? genderTxt;
  String? city;
  String? speciality;

  @override
  void initState() {
    birthDateInString == widget.doctorModel.birthDate!;
    super.initState();
  }

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
            title: "تعديل البيانات الشخصيه",
            txtSize: 20),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customSizedBox(0.0, getheight(context) * 0.1),
            CustomTextField(
              hint: "اسم المستخدم",
              isPassword: false,
              textEditingController: nameController
                ..text = widget.doctorModel.userName!,
              keyboardType: TextInputType.name,
              icon: Icons.man,
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
                          "${birthDate.month}-${birthDate.day}-${birthDate.year}";
                    });
                  }
                }),
            customSizedBox(0.0, 10.0),
            CustomTextField(
              hint: "الموقع",
              textEditingController: locationController
                ..text = widget.doctorModel.location!,
              keyboardType: TextInputType.name,
              icon: Icons.location_on,
              isPassword: false,
            ),
            customSizedBox(0.0, 10.0),
            CustomTextField(
              hint: "المنطقه",
              textEditingController: regionController
                ..text = widget.doctorModel.region!,
              keyboardType: TextInputType.name,
              icon: Icons.location_on_outlined,
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
              textEditingController: specialityDescriptionController
                ..text = widget.doctorModel.title!,
              keyboardType: TextInputType.name,
              icon: Icons.swipe_vertical_outlined,
              isPassword: false,
            ),
            customSizedBox(0.0, 10.0),
            CustomTextField(
              hint: "سعر الكشف",
              textEditingController: priceController
                ..text = widget.doctorModel.price.toString(),
              keyboardType: TextInputType.name,
              icon: Icons.monetization_on,
              isPassword: false,
            ),
            customSizedBox(0.0, 10.0),
            InkWell(
              onTap: () {
                setState(() {
                  ApiRequests().editWholeProfile(
                      context,
                      nameController.text.isEmpty
                          ? widget.doctorModel.userName!
                          : nameController.text.toString(),
                      priceController.text.isEmpty
                          ? widget.doctorModel.price.toString()
                          : priceController.text.toString(),
                      birthDateInString,
                      city == null ? widget.doctorModel.city.toString() : city!,
                      regionController.text.isEmpty
                          ? widget.doctorModel.region.toString()
                          : regionController.text.toString(),
                      speciality == null
                          ? widget.doctorModel.specialty!
                          : speciality!,
                      specialityDescriptionController.text.isEmpty
                          ? widget.doctorModel.title.toString()
                          : specialityDescriptionController.text.toString(),
                      locationController.text.isEmpty
                          ? widget.doctorModel.location.toString()
                          : locationController.text.toString(),
                      phoneController.text.isEmpty
                          ? "null"
                          : phoneController.text.toString());
                });
              },
              child: Center(
                  child: CustomButton(
                      widht: getwidth(context) * 0.8,
                      color: darkenAppColor,
                      title: "حفظ التعديل")),
            ),
          ],
        ),
      ),
    );
  }
}
