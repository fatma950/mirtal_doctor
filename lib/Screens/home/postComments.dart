// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:mirtal_doctor/Constants/colors.dart';
import 'package:mirtal_doctor/Constants/customSizedBox.dart';
import 'package:mirtal_doctor/Screens/home/commentCard.dart';
import 'package:mirtal_doctor/Screens/home/postCardWithoutComment.dart';
import 'package:mirtal_doctor/Screens/home/shimmerCommentList.dart';
import 'package:mirtal_doctor/models/commentsModel.dart';

import '../../Constants/strings.dart';
import '../../Constants/widthandheight.dart';
import '../../data/ApiRequests.dart';
import '../../models/postsModel.dart';
import '../../sharedWidgets/customText.dart';
import '../../sharedWidgets/customTextField.dart';
import '../bottomNavigation/customPagesAppBar.dart';

class PostComments extends StatefulWidget {
  final PostsModel postsModel;
  const PostComments({
    Key? key,
    required this.postsModel,
  }) : super(key: key);

  @override
  State<PostComments> createState() => _PostCommentsState();
}

class _PostCommentsState extends State<PostComments> {
  TextEditingController commentController = TextEditingController();
  CommentsModel? commentsModel;
  bool loading = true;

  @override
  void initState() {
    getAllComments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: customPagesAppbar(),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          customSizedBox(0.0, 10.0),
          MyPostsWithoutComment(
              patientName: widget.postsModel.username,
              description: widget.postsModel.content,
              speciality: widget.postsModel.speciality,
              date: DateFormat.yMd()
                  .format(DateTime.parse(widget.postsModel.time.toString())),
              postID: widget.postsModel.postId),
          customSizedBox(0.0, 10.0),
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: CustomTxt(
                title: "التعليقات",
                txtSize: 20,
                fontWeight: FontWeight.bold,
                color: darkenAppColor,
                ellipsis: false),
          ),
          customSizedBox(0.0, 10.0),
          loading
              ? const Center(
                  child: CommentShimmer(),
                )
              : ListView.builder(
                  itemCount: commentsModel!.post!.comments!.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return commentsModel!
                                .post!.comments![index].doctorComment ==
                            null
                        ? Container()
                        : MyComment(
                            profilePhotoUrl: commentsModel!
                                        .post!
                                        .comments![index]
                                        .doctorComment!
                                        .photo ==
                                    null
                                ? doctorAvater
                                : commentsModel!.post!.comments![index]
                                    .doctorComment!.photo!,
                            doctorName: commentsModel!
                                .post!.comments![index].doctorComment!.userName
                                .toString(),
                            speciality: commentsModel!
                                .post!.comments![index].doctorComment!.specialty
                                .toString(),
                            time: commentsModel!.post!.comments![index].time
                                .toString(),
                            comment: commentsModel!
                                .post!.comments![index].comment
                                .toString());
                  }),
        ],
      )),
      bottomNavigationBar: Container(
        color: myWhite,
        child: Row(
          children: [
            SizedBox(
              width: getwidth(context) * 0.89,
              child: CustomTextField(
                hint: "برجاء كتابه التعليق",
                isPassword: false,
                textEditingController: commentController,
                keyboardType: TextInputType.name,
                icon: Icons.comment,
              ),
            ),
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30), color: appColor),
                width: getwidth(context) * 0.1,
                child: IconButton(
                  onPressed: () {
                    ApiRequests().addComment(widget.postsModel.postId,
                        commentController.text.toString(), context);
                  },
                  icon: Icon(
                    Icons.send,
                    color: myWhite,
                  ),
                )),
          ],
        ),
      ),
    );
  }

  getAllComments() async {
    commentsModel =
        await ApiRequests().getPostComments(widget.postsModel.postId);

    setState(() {
      loading = false;
    });
  }
}
