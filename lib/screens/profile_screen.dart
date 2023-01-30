// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exd_social/controller/singup_screen_controller.dart';
import 'package:exd_social/models/user_model.dart';
import 'package:exd_social/screens/comment_screen.dart';
import 'package:exd_social/screens/edit_profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../models/post_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // SignUpScreenController controller = Get.put(SignUpScreenController());
  User? currentuser = FirebaseAuth.instance.currentUser;
  CollectionReference userRefernce =
      FirebaseFirestore.instance.collection("users");

  CollectionReference postReference =
      FirebaseFirestore.instance.collection("post");
  List<PostModel> checkList = [];
  Stream<List<PostModel>> getPost() async* {
    List<PostModel> postList = [];
    QuerySnapshot ref = await postReference
        .where("uid", isEqualTo: currentuser!.uid)
        .orderBy("dateTime", descending: true)
        .get();
    for (var i = 0; i < ref.docs.length; i++) {
      PostModel post =
          PostModel.fromDocumentSnapshot(documentSnapshot: ref.docs[i]);
      postList.add(post);
      checkList = postList;
    }
    yield postList;
  }

  Stream getProfile() async* {
    DocumentSnapshot user = await userRefernce.doc(currentuser!.uid).get();
    yield user;
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark),
        backgroundColor: Colors.white,
        elevation: 1,
        shadowColor: Color.fromARGB(255, 227, 97, 41),
        title: Text(
          "Profile",
          style: TextStyle(color: Colors.black),
        ),
        leading: InkWell(
          splashColor: Colors.transparent,
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color.fromARGB(255, 227, 97, 41),
          ),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: GetBuilder<SignUpScreenController>(
        init: SignUpScreenController(),
        initState: (_) {},
        builder: (data) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StreamBuilder(
                  stream: getProfile(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Text(
                          "Loading.....",
                          style: TextStyle(
                              color: Color.fromARGB(255, 28, 70, 130),
                              fontSize: 18),
                        ),
                      );
                    } else if (snapshot.hasData) {
                      UserModel userData = UserModel.fromjson(
                          snapshot.data!.data() as Map<String, dynamic>);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: Stack(
                              children: [
                                Container(
                                  height: height * 0.25,
                                  width: width,
                                  // color: Colors.red,
                                  child: Image.network(
                                    userData.coverImageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: width * 0.03, top: height * 0.12),
                                  height: height * 0.18,
                                  width: width * 0.4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                        width: 5,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255)),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.network(
                                      userData.imageUrl,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: width * 0.05,
                                right: width * 0.05,
                                top: height * 0.02),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: width * 0.8,
                                  // color: Colors.blue,
                                  child: Text(
                                    userData.firstName,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 26),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Get.to(EditProfileScreen(
                                      detail: userData,
                                    ));
                                  },
                                  child: Icon(
                                    Icons.edit_outlined,
                                    color: Color.fromARGB(255, 227, 97, 41),
                                    size: 30,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Divider(
                            indent: width * 0.05,
                            endIndent: width * 0.05,
                            height: height * 0.02,
                            thickness: 1,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: width * 0.05,
                                    top: height * 0.01,
                                    bottom: height * 0.01),
                                child: Container(
                                  child: Text(
                                    "Contact info",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                              ListTile(
                                visualDensity: VisualDensity(vertical: -2),
                                leading: Container(
                                  height: height * 0.053,
                                  width: width * 0.13,
                                  // color: Colors.green,

                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          Color.fromARGB(255, 232, 233, 237)),
                                  child: Icon(
                                    CupertinoIcons.mail_solid,
                                    color: Colors.black,
                                    size: 22,
                                  ),
                                ),
                                title: Text(
                                  userData.metadata.email,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                                subtitle: Text(
                                  "Email",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 227, 97, 41),
                                      fontSize: 14),
                                ),
                              ),
                              Divider(
                                indent: width * 0.22,
                                endIndent: width * 0.05,
                                height: height * 0,
                                thickness: 1,
                              ),
                              ListTile(
                                visualDensity: VisualDensity(vertical: -2),
                                leading: Container(
                                  height: height * 0.053,
                                  width: width * 0.13,
                                  // color: Colors.green,

                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          Color.fromARGB(255, 232, 233, 237)),
                                  child: Icon(
                                    Icons.call,
                                    color: Colors.black,
                                    size: 22,
                                  ),
                                ),
                                title: Text(
                                  userData.phone,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                                subtitle: Text(
                                  "Phone",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 227, 97, 41),
                                      fontSize: 14),
                                ),
                              ),
                              Divider(
                                indent: width * 0.05,
                                endIndent: width * 0.05,
                                height: height * 0.02,
                                thickness: 1,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: width * 0.05,
                                    top: height * 0.01,
                                    bottom: height * 0.01),
                                child: Container(
                                  child: Text(
                                    "Basic info",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                              ListTile(
                                visualDensity: VisualDensity(vertical: -2),
                                leading: Container(
                                  height: height * 0.053,
                                  width: width * 0.13,
                                  // color: Colors.green,

                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          Color.fromARGB(255, 232, 233, 237)),
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.black,
                                    size: 22,
                                  ),
                                ),
                                title: Text(
                                  userData.gender,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                                subtitle: Text(
                                  "Gender",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 227, 97, 41),
                                      fontSize: 14),
                                ),
                              ),
                              Divider(
                                indent: width * 0.22,
                                endIndent: width * 0.05,
                                height: height * 0,
                                thickness: 1,
                              ),
                              ListTile(
                                visualDensity: VisualDensity(vertical: -2),
                                leading: Container(
                                  height: height * 0.053,
                                  width: width * 0.13,
                                  // color: Colors.green,

                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          Color.fromARGB(255, 232, 233, 237)),
                                  child: Icon(
                                    Icons.cake_rounded,
                                    color: Colors.black,
                                    size: 22,
                                  ),
                                ),
                                title: Text(
                                  userData.birthday,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                                subtitle: Text(
                                  "Birthday",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 227, 97, 41),
                                      fontSize: 14),
                                ),
                              ),
                              Divider(
                                indent: width * 0.05,
                                endIndent: width * 0.05,
                                height: height * 0.02,
                                thickness: 1,
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: width * 0.05,
                                    top: height * 0.01,
                                    bottom: height * 0.01),
                                child: Container(
                                  child: Text(
                                    " Places lived",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                              ListTile(
                                visualDensity: VisualDensity(vertical: -2),
                                leading: Container(
                                  height: height * 0.053,
                                  width: width * 0.13,
                                  // color: Colors.green,

                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          Color.fromARGB(255, 232, 233, 237)),
                                  child: Icon(
                                    Icons.home_rounded,
                                    color: Colors.black,
                                    size: 22,
                                  ),
                                ),
                                title: Text(
                                  userData.homeTown,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                                subtitle: Text(
                                  "Home town",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 227, 97, 41),
                                      fontSize: 14),
                                ),
                              ),
                              Divider(
                                indent: width * 0.22,
                                endIndent: width * 0.05,
                                height: height * 0,
                                thickness: 1,
                              ),
                              ListTile(
                                visualDensity: VisualDensity(vertical: -2),
                                leading: Container(
                                  height: height * 0.053,
                                  width: width * 0.13,
                                  // color: Colors.green,

                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          Color.fromARGB(255, 232, 233, 237)),
                                  child: Icon(
                                    Icons.location_on_rounded,
                                    color: Colors.black,
                                    size: 22,
                                  ),
                                ),
                                title: Text(
                                  userData.location,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                                subtitle: Text(
                                  "Last Location",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 227, 97, 41),
                                      fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Something went wrong!",
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      );
                    }
                    return Container();
                  }),
              Divider(
                height: height * 0.04,
                thickness: 9,
              ),
              StreamBuilder<List<PostModel>>(
                  stream: getPost(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<PostModel>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Text(
                          "Loading.....",
                          style: TextStyle(
                              color: Color.fromARGB(255, 28, 70, 130),
                              fontSize: 18),
                        ),
                      );
                    } else if (snapshot.hasData) {
                      if (checkList.isNotEmpty) {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemBuilder: (BuildContext context, index) {
                            PostModel screenData = snapshot.data![index];
                            return Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: width * 0.04),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                                height: height * 0.054,
                                                width: width * 0.12,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100),
                                                  child: Image.network(
                                                    screenData.profileImage,
                                                    fit: BoxFit.cover,
                                                  ),
                                                )),
                                            SizedBox(
                                              width: width * 0.03,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  screenData.userName,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 17),
                                                ),
                                                SizedBox(
                                                  height: height * 0.005,
                                                ),
                                                Text(
                                                  screenData.dateTime,
                                                  style: TextStyle(
                                                      fontSize: 13,
                                                      color: Color.fromARGB(
                                                          255, 28, 70, 130)),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              bottom: height * 0.025),
                                          child: IconButton(
                                              splashColor: Colors.transparent,
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.close_rounded,
                                                size: 25,
                                                color: Color.fromARGB(
                                                    255, 62, 60, 60),
                                              )),
                                        )
                                      ],
                                    ),
                                  ),
                                  screenData.postText.isNotEmpty
                                      ? Padding(
                                          padding: EdgeInsets.only(
                                              left: width * 0.04,
                                              right: width * 0.04,
                                              top: height * 0.01,
                                              bottom: height * 0.01),
                                          child: Container(
                                            child: Text(
                                              screenData.postText,
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                        )
                                      : Container(),
                                  screenData.postImage.isNotEmpty
                                      ? Container(
                                          width: width,
                                          child: Image.network(
                                            screenData.postImage,
                                            fit: BoxFit.fitHeight,
                                          ),
                                        )
                                      : Container(),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: width * 0.04,
                                        right: width * 0.04,
                                        top: height * 0.01,
                                        bottom: height * 0.01),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Text(
                                            "1.2K",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            "42 comments",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: width * 0.04,
                                        right: width * 0.04),
                                    child: Divider(
                                      height: height * 0.006,
                                      thickness: 0.6,
                                      // color: Colors.grey,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: width * 0.08,
                                      right: width * 0.08,
                                      top: height * 0.01,
                                      bottom: height * 0.01,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () {},
                                          child: Container(
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.thumb_up_alt_outlined,
                                                  color: Colors.grey,
                                                ),
                                                SizedBox(
                                                  width: width * 0.02,
                                                ),
                                                Text(
                                                  "Like",
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () {
                                            Get.to(CommentScreen(
                                                detail: screenData));
                                          },
                                          child: Container(
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons
                                                      .messenger_outline_rounded,
                                                  color: Colors.grey,
                                                ),
                                                SizedBox(
                                                  width: width * 0.02,
                                                ),
                                                Text(
                                                  "Comment",
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () {},
                                          child: Container(
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.send_outlined,
                                                  color: Colors.grey,
                                                ),
                                                SizedBox(
                                                  width: width * 0.02,
                                                ),
                                                Text(
                                                  "Share",
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    height: height * 0.02,
                                    thickness: 9,
                                    // color: Colors.grey,
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      } else {
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "No posts",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        );
                      }
                    } else if (snapshot.hasError) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Something went wrong!",
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      );
                    }
                    return Container();
                  }),
              SizedBox(
                height: height * 0.03,
              )
            ],
          );
        },
      ))),
    );
  }
}
