// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mirtal_doctor/Constants/colors.dart';
import 'package:mirtal_doctor/Constants/customSizedBox.dart';
import 'package:mirtal_doctor/Constants/myNavigator.dart';
import 'package:mirtal_doctor/Screens/onlineClendar/AllDayReservations.dart';
import 'package:mirtal_doctor/data/ApiRequests.dart';
import 'package:mirtal_doctor/models/reservationModel.dart';
import 'package:mirtal_doctor/sharedWidgets/customButton.dart';
import 'package:mirtal_doctor/sharedWidgets/customText.dart';
import 'package:url_launcher/url_launcher.dart';

class MyReservation extends StatefulWidget {
  const MyReservation({Key? key}) : super(key: key);

  @override
  State<MyReservation> createState() => _MyReservationState();
}

class _MyReservationState extends State<MyReservation> {
  bool loading = true;
  ReservationModel? reservationModel;

  String searchedDayInString = "";
  DateTime searchedDay = DateTime.now();
  bool isDateSelected = false;

  @override
  void initState() {
    getAllReservations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: myGrey.withOpacity(0.1),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Center(
              child: CustomTxt(
                  title: "جميع الحجوزات",
                  txtSize: 28,
                  fontWeight: FontWeight.bold,
                  color: darkenAppColor,
                  ellipsis: false),
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
                              title: searchedDayInString == ""
                                  ? "يمكنك اختيار يوم معين لعرض الحجوزات الخاصه به من هنا"
                                  : "اليوم المختار : " + searchedDayInString,
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
                  if (datePick != null && datePick != searchedDay) {
                    setState(() {
                      searchedDay = datePick;
                      isDateSelected = true;

                      searchedDayInString =
                          "${searchedDay.year}-${searchedDay.month}-${searchedDay.day}";
                    });
                  }
                }),
            customSizedBox(0.0, 10.0),
            InkWell(
              onTap: () {
                MyNavigetor().push(
                    AllDayReservations(searchedDay: searchedDayInString),
                    context);
              },
              child: CustomButton(
                color: darkenAppColor,
                title: "ابدأ عرض الحجوزات الخاصه باليوم المختار",
                widht: double.infinity,
              ),
            ),
            customSizedBox(0.0, 20.0),
            loading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: reservationModel!.totalRes,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      if (reservationModel!
                              .getAllReservation![index].reservationPlace ==
                          "مكالمه فيديو") {
                        return Container(
                          margin: const EdgeInsets.all(15.0),
                          padding: const EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                              color: myWhite,
                              borderRadius: BorderRadius.circular(20.0),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: myWhite,
                                    offset: const Offset(4, 4),
                                    blurRadius: 10)
                              ]),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    ClipRRect(
                                      child: Image.asset(
                                        reservationModel!
                                                    .getAllReservation![index]
                                                    .patient ==
                                                null
                                            ? "assets/boy.png"
                                            : reservationModel!
                                                        .getAllReservation![
                                                            index]
                                                        .patient!
                                                        .gender ==
                                                    "male"
                                                ? "assets/boy.png"
                                                : "assets/woman.png",
                                        width: 50.0,
                                        height: 50.0,
                                      ),
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    customSizedBox(10.0, 0.0),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomTxt(
                                            title: reservationModel!
                                                        .getAllReservation![
                                                            index]
                                                        .patient ==
                                                    null
                                                ? "الأسم : " "null"
                                                : "الأسم : " +
                                                    reservationModel!
                                                        .getAllReservation![
                                                            index]
                                                        .patient!
                                                        .userName
                                                        .toString(),
                                            txtSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: darkenAppColor,
                                            ellipsis: false),
                                        customSizedBox(0.0, 3.0),
                                        CustomTxt(
                                            title: "رقم الموبايل : " +
                                                reservationModel!
                                                    .getAllReservation![index]
                                                    .phone
                                                    .toString(),
                                            txtSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: darkenAppColor,
                                            ellipsis: false),
                                        CustomTxt(
                                            title: "التاريخ : " +
                                                reservationModel!
                                                    .getAllReservation![index]
                                                    .time
                                                    .toString(),
                                            txtSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: darkenAppColor,
                                            ellipsis: false),
                                        CustomTxt(
                                            title: "بداية الكشف : " +
                                                reservationModel!
                                                    .getAllReservation![index]
                                                    .start
                                                    .toString(),
                                            txtSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: darkenAppColor,
                                            ellipsis: false),
                                        CustomTxt(
                                            title: reservationModel!
                                                        .getAllReservation![
                                                            index]
                                                        .isPaid ==
                                                    true
                                                ? "الدفع : " "مدفوع"
                                                : "الدفع : " " غير مدفوع",
                                            txtSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: darkenAppColor,
                                            ellipsis: false),
                                        CustomTxt(
                                            title: "اجمالى الدفع : " +
                                                reservationModel!
                                                    .getAllReservation![index]
                                                    .totalPaid
                                                    .toString() +
                                                " EG",
                                            txtSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: darkenAppColor,
                                            ellipsis: false),
                                      ],
                                    ),
                                  ],
                                ),
                                customSizedBox(0.0, 10.0),
                                InkWell(
                                    onTap: () async {
                                      if (!await launchUrl(Uri.parse(
                                          reservationModel!
                                              .getAllReservation![index]
                                              .meeting!))) {
                                        throw 'Could not launch';
                                      }
                                    },
                                    child: CustomButton(
                                        widht: double.infinity,
                                        color: appColor,
                                        title: "ابدأ الميتينج الان"))
                              ]),
                        );
                      } else {
                        return Container();
                      }
                    }),
          ]),
        ),
      ),
    );
  }

  getAllReservations() async {
    reservationModel = await ApiRequests().getAllReservations();
    setState(() {
      loading = false;
    });
  }
}
