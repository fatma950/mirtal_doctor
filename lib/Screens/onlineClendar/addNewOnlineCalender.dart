// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mirtal_doctor/data/ApiRequests.dart';

import '../../Constants/colors.dart';
import '../../Constants/customSizedBox.dart';
import '../../data/weekDays.dart';
import '../../sharedWidgets/customButton.dart';
import '../../sharedWidgets/customText.dart';
import '../../sharedWidgets/customTextField.dart';
import '../Auth/defaultAuthAppbar.dart';

class AddNewOnlineCalender extends StatefulWidget {
  const AddNewOnlineCalender({Key? key}) : super(key: key);

  @override
  State<AddNewOnlineCalender> createState() => _AddNewOnlineCalenderState();
}

class _AddNewOnlineCalenderState extends State<AddNewOnlineCalender> {
  TextEditingController from = TextEditingController();
  TextEditingController to = TextEditingController();
  String? _weekDaySelection;
  String onlineCalendarDateInString = "";
  DateTime onlineCalendarDate = DateTime.now();
  bool isDateSelected = false;
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
                title: "أضافه معاد جديد",
                txtSize: 20,
                fontWeight: FontWeight.bold,
                color: darkenAppColor,
                ellipsis: false),
          ),
          customSizedBox(0.0, 20.0),
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
                  child: Text("من فضلك اختر اليوم"),
                ),
                isExpanded: true,
                items: weekDays.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                value: _weekDaySelection,
                onChanged: (newValue) {
                  setState(() {
                    _weekDaySelection = newValue;
                  });
                },
              ),
            ),
          ),
          customSizedBox(0.0, 20.0),
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
                            title: onlineCalendarDateInString == ""
                                ? DateFormat("yyyy-MM-dd")
                                    .format(DateTime.now())
                                : onlineCalendarDateInString,
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
                if (datePick != null && datePick != onlineCalendarDate) {
                  setState(() {
                    onlineCalendarDate = datePick;
                    isDateSelected = true;

                    onlineCalendarDateInString =
                        "${onlineCalendarDate.day}-${onlineCalendarDate.month}-${onlineCalendarDate.year}";
                  });
                }
              }),
          customSizedBox(0.0, 20.0),
          CustomTextField(
            hint: "من",
            isPassword: false,
            textEditingController: from,
            keyboardType: TextInputType.emailAddress,
            icon: Icons.timelapse,
          ),
          customSizedBox(0.0, 20.0),
          CustomTextField(
            isPassword: false,
            hint: "الى",
            textEditingController: to,
            keyboardType: TextInputType.emailAddress,
            icon: Icons.timelapse,
          ),
          customSizedBox(0.0, 20.0),
          Center(
              child: InkWell(
            onTap: () {
              ApiRequests().addOnlineCalender(
                  _weekDaySelection!,
                  onlineCalendarDateInString,
                  from.text.toString(),
                  to.text.toString(),
                  context);
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
