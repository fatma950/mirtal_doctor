// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:mirtal_doctor/Constants/widthandheight.dart';
import 'package:mirtal_doctor/models/doctorModel.dart';

import '../../Constants/colors.dart';
import '../../Constants/customSizedBox.dart';
import '../../data/ApiRequests.dart';
import '../../data/weekDays.dart';
import '../../sharedWidgets/customButton.dart';
import '../../sharedWidgets/customText.dart';
import '../../sharedWidgets/customTextField.dart';

class EditCalender extends StatefulWidget {
  final TeleCalender calender;
  const EditCalender({
    Key? key,
    required this.calender,
  }) : super(key: key);

  @override
  State<EditCalender> createState() => _EditCalenderState();
}

class _EditCalenderState extends State<EditCalender> {
  TextEditingController from = TextEditingController();
  TextEditingController to = TextEditingController();
  String? _weekDaySelection;
  String onlineCalendarDateInString = "";
  DateTime onlineCalendarDate = DateTime.now();
  bool isDateSelected = false;
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
            title: "تعديل الميعاد",
            txtSize: 20),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customSizedBox(0.0, getheight(context) * 0.1),
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
                        "${onlineCalendarDate.month}-${onlineCalendarDate.day}-${onlineCalendarDate.year}";
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
              ApiRequests().editCalender(
                  context,
                  widget.calender.sId!,
                  _weekDaySelection == null
                      ? widget.calender.weekday!
                      : _weekDaySelection!,
                  onlineCalendarDateInString.isEmpty
                      ? DateFormat("yyyy-MM-dd").format(DateTime.now())
                      : onlineCalendarDateInString,
                  from.text.isEmpty
                      ? widget.calender.startAt!
                      : from.text.toString(),
                  to.text.isEmpty
                      ? widget.calender.endAt!
                      : to.text.toString());
            },
            child: CustomButton(
                widht: MediaQuery.of(context).size.width * 0.9,
                color: darkenAppColor,
                title: "تعديل"),
          )),
        ],
      )),
    );
  }
}
