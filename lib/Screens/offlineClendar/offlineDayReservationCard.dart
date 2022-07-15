// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mirtal_doctor/Constants/colors.dart';
import 'package:mirtal_doctor/Constants/customSizedBox.dart';
import 'package:mirtal_doctor/Constants/myNavigator.dart';
import 'package:mirtal_doctor/Constants/widthandheight.dart';
import 'package:mirtal_doctor/Screens/offlineClendar/addNewOfflineCalendar.dart';
import 'package:mirtal_doctor/Screens/offlineClendar/editOfflineCalender.dart';
import 'package:mirtal_doctor/models/doctorModel.dart';
import 'package:mirtal_doctor/sharedWidgets/customButton.dart';

import '../../data/ApiRequests.dart';

class OfflineDayReservationCard extends StatefulWidget {
  const OfflineDayReservationCard({
    Key? key,
  }) : super(key: key);

  @override
  State<OfflineDayReservationCard> createState() =>
      _OfflineDayReservationCardState();
}

class _OfflineDayReservationCardState extends State<OfflineDayReservationCard> {
  DoctorModel? doctorModel;
  bool loading = true;
  @override
  void initState() {
    getCalenders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : doctorModel!.calender!.isEmpty
            ? Center(
                child: InkWell(
                  onTap: () {
                    MyNavigetor().push(const AddNewOfflineCalender(), context);
                  },
                  child: CustomButton(
                      widht: getwidth(context) * 0.5,
                      color: darkenAppColor,
                      title: "ليس لديك مواعيد ... برجاء اضافة معاد"),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 2 / 3.8,
                        crossAxisSpacing: 1,
                        mainAxisSpacing: 1,
                      ),
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: doctorModel!.calender!.length,
                      itemBuilder: (ctx, index) {
                        return Container(
                          //padding: const EdgeInsets.all(10.0),
                          margin: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              color: myWhite,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 30,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: darkenAppColor,
                                  ),
                                  child: Text(
                                    doctorModel!.calender![index].weekday!,
                                    style: TextStyle(
                                        color: myWhite,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                customSizedBox(0.0, 10.0),
                                Text("من",
                                    style: TextStyle(color: darkenAppColor)),
                                customSizedBox(0.0, 10.0),
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 5.0, right: 5.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: darkenAppColor,
                                  ),
                                  child: Text(
                                      doctorModel!.calender![index].startAt!,
                                      style: TextStyle(color: myWhite)),
                                ),
                                customSizedBox(0.0, 10.0),
                                Text("الى",
                                    style: TextStyle(color: darkenAppColor)),
                                customSizedBox(0.0, 10.0),
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 5.0, right: 5.0),
                                  //width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    color: darkenAppColor,
                                  ),
                                  child: Text(
                                      doctorModel!.calender![index].endAt!,
                                      style: TextStyle(color: myWhite)),
                                ),
                                customSizedBox(0.0, 15.0),
                                InkWell(
                                  onTap: () async {
                                    MyNavigetor().push(
                                        EditOfflineCalender(
                                            calender:
                                                doctorModel!.calender![index]),
                                        context);
                                  },
                                  child: Container(
                                    height: 30,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      color: Colors.green,
                                    ),
                                    child: Text("تعديل هذا الميعاد",
                                        style: TextStyle(
                                            color: myWhite,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                                customSizedBox(0.0, 15.0),
                                InkWell(
                                  onTap: () async {
                                    //print(doctorModel!.calender![index].sId);
                                    await ApiRequests().deleteCalender(
                                        context,
                                        doctorModel!.calender![index].sId!
                                            .toString());
                                  },
                                  child: Container(
                                    height: 30,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      color: Colors.red,
                                    ),
                                    child: Text("حذف هذا الميعاد",
                                        style: TextStyle(
                                            color: myWhite,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ]),
                        );
                      },
                    ),
                    //   const Spacer(),
                    InkWell(
                      onTap: () {
                        MyNavigetor()
                            .push(const AddNewOfflineCalender(), context);
                      },
                      child: CustomButton(
                          widht: double.infinity,
                          color: darkenAppColor,
                          title: "اضافه معاد جديد"),
                    )
                  ],
                ),
              );
  }

  getCalenders() async {
    doctorModel = await ApiRequests.getUserProfile();

    setState(() {
      loading = false;
    });
  }
}
