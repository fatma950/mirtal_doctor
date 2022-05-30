// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mirtal_doctor/Constants/customSizedBox.dart';
import 'package:mirtal_doctor/Constants/widthandheight.dart';
import 'package:mirtal_doctor/sharedWidgets/customText.dart';

import '../../Constants/colors.dart';

class MyOfflineDayReservation extends StatelessWidget {
  const MyOfflineDayReservation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myWhite,
      appBar: AppBar(
        title: const Text("يوم السبت"),
        centerTitle: true,
        backgroundColor: darkenAppColor,
      ),
      body: Container(
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
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: Image.asset(
                                'assets/Capture2.JPG',
                                width: 50,
                                fit: BoxFit.cover,
                                height: 50,
                              ),
                            ),
                            customSizedBox(5.0, 0.0),
                            CustomTxt(
                                title: "فارس أحمد",
                                txtSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: darkenAppColor,
                                ellipsis: false),
                          ],
                        ),
                        CustomTxt(
                            title: "9.00 صباحا",
                            txtSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: darkenAppColor,
                            ellipsis: false),
                      ],
                    ),
                    customSizedBox(0.0, 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: getwidth(context) * 0.40,
                          child: ElevatedButton(
                              style:
                                  ElevatedButton.styleFrom(primary: appColor),
                              onPressed: () {},
                              child: const Text("تم الكشف")),
                        ),
                        SizedBox(
                          width: getwidth(context) * 0.40,
                          child: ElevatedButton(
                              style:
                                  ElevatedButton.styleFrom(primary: Colors.red),
                              onPressed: () {},
                              child: const Text("متأخر")),
                        )
                      ],
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}
