// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mirtal_doctor/Constants/colors.dart';
import 'package:mirtal_doctor/Constants/myNavigator.dart';
import 'package:mirtal_doctor/Screens/onlineClendar/MyDayReservation.dart';
import 'package:mirtal_doctor/sharedWidgets/customText.dart';

class MyReservation extends StatelessWidget {
  const MyReservation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          CustomTxt(
              title: "حجوزات سابقه",
              txtSize: 15.0,
              fontWeight: FontWeight.bold,
              color: myBlack,
              ellipsis: false),
          Container(
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.all(10.0),
            color: darkenAppColor,
            child: ListView.builder(
                itemCount: 2,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      MyNavigetor().push(const MyDayReservation(), context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      margin: const EdgeInsets.all(10.0),
                      color: myWhite,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                CustomTxt(
                                    title: "يوم السبت",
                                    txtSize: 13.0,
                                    fontWeight: FontWeight.bold,
                                    color: myGrey,
                                    ellipsis: false),
                                CustomTxt(
                                    title: "19-2-2022",
                                    txtSize: 10.0,
                                    fontWeight: FontWeight.bold,
                                    color: myGrey,
                                    ellipsis: false)
                              ],
                            ),
                            const Icon(Icons.door_back_door)
                          ]),
                    ),
                  );
                }),
          ),
          CustomTxt(
              title: "حجوزات حديثه",
              txtSize: 15.0,
              fontWeight: FontWeight.bold,
              color: myBlack,
              ellipsis: false),
          Container(
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.all(10.0),
            color: darkenAppColor,
            child: ListView.builder(
                itemCount: 2,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    padding: const EdgeInsets.all(10.0),
                    margin: const EdgeInsets.all(10.0),
                    color: myWhite,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              CustomTxt(
                                  title: "يوم السبت",
                                  txtSize: 13.0,
                                  fontWeight: FontWeight.bold,
                                  color: myGrey,
                                  ellipsis: false),
                              CustomTxt(
                                  title: "19-2-2022",
                                  txtSize: 10.0,
                                  fontWeight: FontWeight.bold,
                                  color: myGrey,
                                  ellipsis: false)
                            ],
                          ),
                          const Icon(Icons.refresh)
                        ]),
                  );
                }),
          ),
        ]),
      ),
    );
  }
}
