// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mirtal_doctor/Constants/colors.dart';
import 'package:mirtal_doctor/models/AllDayReservationsModel.dart';
import 'package:mirtal_doctor/sharedWidgets/customText.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Constants/customSizedBox.dart';
import '../../data/ApiRequests.dart';
import '../../sharedWidgets/customButton.dart';

class AllDayReservations extends StatefulWidget {
  final String searchedDay;
  const AllDayReservations({
    Key? key,
    required this.searchedDay,
  }) : super(key: key);

  @override
  State<AllDayReservations> createState() => _AllDayReservationsState();
}

class _AllDayReservationsState extends State<AllDayReservations> {
  bool loading = true;
  AllDayReservationsModel? reservationModel;

  @override
  void initState() {
    getAllDayReservations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: darkenAppColor,
        centerTitle: true,
        title: CustomTxt(
            title: widget.searchedDay,
            txtSize: 20,
            fontWeight: FontWeight.bold,
            color: myWhite,
            ellipsis: false),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Center(
            child: CustomTxt(
                title: "جميع الحجوزات",
                txtSize: 28,
                fontWeight: FontWeight.bold,
                color: darkenAppColor,
                ellipsis: false),
          ),
          loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : reservationModel!.reservation!.isEmpty
                  ? Container(
                      padding: const EdgeInsets.all(20.0),
                      margin: const EdgeInsets.all(20.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: myGrey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20.0)),
                      child: CustomTxt(
                          title:
                              "لا يوجد حجوزات فى هذا اليوم برجاء المحاوله بيوم اخر ....",
                          txtSize: 18,
                          fontWeight: FontWeight.bold,
                          color: darkenAppColor,
                          ellipsis: false),
                    )
                  : ListView.builder(
                      itemCount: reservationModel!.totalRes,
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        if (reservationModel!
                                .reservation![index].reservationPlace ==
                            "مكالمه فيديو") {
                          return Container(
                            margin: const EdgeInsets.all(15.0),
                            padding: const EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                                color: myGrey.withOpacity(0.4),
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
                                          reservationModel!.reservation![index]
                                                      .patient ==
                                                  null
                                              ? "assets/boy.png"
                                              : reservationModel!
                                                          .reservation![index]
                                                          .patient!
                                                          .gender ==
                                                      "male"
                                                  ? "assets/boy.png"
                                                  : "assets/woman.png",
                                          width: 50.0,
                                          height: 50.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                      ),
                                      customSizedBox(10.0, 0.0),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomTxt(
                                              title: reservationModel!
                                                          .reservation![index]
                                                          .patient ==
                                                      null
                                                  ? "الأسم : " "null"
                                                  : "الأسم : " +
                                                      reservationModel!
                                                          .reservation![index]
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
                                                      .reservation![index].phone
                                                      .toString(),
                                              txtSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              color: darkenAppColor,
                                              ellipsis: false),
                                          CustomTxt(
                                              title: "التاريخ : " +
                                                  reservationModel!
                                                      .reservation![index].time
                                                      .toString(),
                                              txtSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              color: darkenAppColor,
                                              ellipsis: false),
                                          CustomTxt(
                                              title: "بداية الكشف : " +
                                                  reservationModel!
                                                      .reservation![index].start
                                                      .toString(),
                                              txtSize: 18.0,
                                              fontWeight: FontWeight.bold,
                                              color: darkenAppColor,
                                              ellipsis: false),
                                          CustomTxt(
                                              title: reservationModel!
                                                          .reservation![index]
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
                                                      .reservation![index]
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
                                                .reservation![index]
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
                      })
        ],
      )),
    );
  }

  getAllDayReservations() async {
    reservationModel =
        await ApiRequests().gelAllDayReservations(widget.searchedDay);

    setState(() {
      loading = false;
    });
  }
}
