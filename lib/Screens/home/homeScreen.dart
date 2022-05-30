// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mirtal_doctor/Constants/colors.dart';
import 'package:mirtal_doctor/Constants/customSizedBox.dart';
import 'package:mirtal_doctor/Constants/myNavigator.dart';
import 'package:mirtal_doctor/Screens/bottomNavigation/customPagesAppBar.dart';
import 'package:mirtal_doctor/Screens/home/postComments.dart';
import 'package:mirtal_doctor/Screens/home/postsCard.dart';
import 'package:mirtal_doctor/data/ApiRequests.dart';
import 'package:mirtal_doctor/models/postsModel.dart';
import 'package:mirtal_doctor/sharedWidgets/customText.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool loading = true;
  List<PostsModel> postsModel = [];

  @override
  void initState() {
    getAllPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customPagesAppbar(),
      backgroundColor: myGrey.withOpacity(0.2),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customSizedBox(0.0, 10.0),
                Padding(
                  padding: const EdgeInsets.only(right: 15.0),
                  child: CustomTxt(
                      title: "منشورات المرضى",
                      txtSize: 20,
                      fontWeight: FontWeight.bold,
                      color: darkenAppColor,
                      ellipsis: false),
                ),
                customSizedBox(0.0, 10.0),
                ListView.builder(
                    itemCount: postsModel.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          MyNavigetor().push(
                              PostComments(postsModel: postsModel[index]),
                              context);
                        },
                        child: MyPosts(
                          postID: postsModel[index].postId,
                          patientName: postsModel[index].username,
                          description: postsModel[index].content,
                          speciality: postsModel[index].speciality,
                          date: DateFormat.yMd().format(DateTime.parse(
                              postsModel[index].time.toString())),
                        ),
                      );
                    })
              ],
            )),
    );
  }

  getAllPost() async {
    postsModel = await ApiRequests.getAllPosts();
    //print(postsModel);
    setState(() {
      loading = false;
    });
  }
}
