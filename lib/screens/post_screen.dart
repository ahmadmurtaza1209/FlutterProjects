// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exd_social/controller/create_post_screen_controller.dart';
import 'package:exd_social/controller/singup_screen_controller.dart';
import 'package:exd_social/database/firebase_auth.dart';
import 'package:exd_social/models/post_model.dart';
import 'package:exd_social/models/user_model.dart';
import 'package:exd_social/screens/all_user_screen.dart';
import 'package:exd_social/screens/chat/rooms.dart';
import 'package:exd_social/screens/comment_screen.dart';
import 'package:exd_social/screens/create_post_screen.dart';
import 'package:exd_social/screens/location_screen.dart';
import 'package:exd_social/screens/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  // SignUpScreenController controller = Get.put(SignUpScreenController());
  User? currentuser = FirebaseAuth.instance.currentUser;
  CollectionReference userRefernce =
      FirebaseFirestore.instance.collection("users");
  CollectionReference postReference =
      FirebaseFirestore.instance.collection("post");
  Stream<List<PostModel>> getPost() async* {
    List<PostModel> postList = [];
    QuerySnapshot ref = await postReference.get();
    for (var i = 0; i < ref.docs.length; i++) {
      PostModel post =
          // PostModel.fromDocumentSnapshot(documentSnapshot: ref.docs[i]);
          PostModel.fromDocumentSnapshot(documentSnapshot: ref.docs[i]);
      postList.add(post);
    }
    yield postList;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPost();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        key: _key,
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        drawer: Drawer(
          width: width * 0.65,
          child: ListView(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              FutureBuilder(
                  future: userRefernce.doc(currentuser!.uid).get(),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.hasData) {
                      UserModel userData = UserModel.fromjson(
                          snapshot.data!.data() as Map<String, dynamic>);
                      return UserAccountsDrawerHeader(
                        accountName: Text(
                          userData.firstName,
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                        accountEmail: Text(
                          userData.metadata.email,
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 227, 97, 41)),
                        currentAccountPicture: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.network(
                            userData.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Container(
                        child: Text(
                          "Errorr!!!!!",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      );
                    }
                    return Container();
                  }),
              ListTile(
                onTap: () {
                  Get.to(ProfileScreen());
                },
                leading: Icon(
                  CupertinoIcons.person,
                  size: 25,
                  color: Color.fromARGB(255, 227, 97, 41),
                ),
                title: Text(
                  "Profile",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 227, 97, 41)),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 25,
                  color: Color.fromARGB(255, 227, 97, 41),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Get.to(RoomsPage());
                },
                leading: Icon(
                  CupertinoIcons.chat_bubble_2,
                  size: 25,
                  color: Color.fromARGB(255, 227, 97, 41),
                ),
                title: Text(
                  "Chats",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 227, 97, 41)),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 25,
                  color: Color.fromARGB(255, 227, 97, 41),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  Get.to(LocationScreen());
                },
                leading: Icon(
                  CupertinoIcons.location,
                  size: 25,
                  color: Color.fromARGB(255, 227, 97, 41),
                ),
                title: Text(
                  "Location",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 227, 97, 41)),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 25,
                  color: Color.fromARGB(255, 227, 97, 41),
                ),
              ),
              ListTile(
                onTap: () {
                  Auth.logoutUser();
                },
                leading: Icon(
                  Icons.login_rounded,
                  size: 22,
                  color: Color.fromARGB(255, 227, 97, 41),
                ),
                title: Text(
                  "Sign Out",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 227, 97, 41)),
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark),
          backgroundColor: Colors.white,
          elevation: 1,
          shadowColor: Color.fromARGB(255, 227, 97, 41),
          leading: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () {
              _key.currentState!.openDrawer();
            },
            child: Icon(
              Icons.menu_rounded,
              color: Color.fromARGB(255, 227, 97, 41),
            ),
          ),
          actions: [
            Container(
              width: width * 0.3,
              child: Image.asset(
                "Assets/images/appBar_logo.png",
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
        body: SafeArea(
            child: GetBuilder<CreatePostScreenController>(
          init: CreatePostScreenController(),
          initState: (_) {},
          builder: (data) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder(
                    future: userRefernce.doc(currentuser!.uid).get(),
                    builder: (BuildContext context, snapshot) {
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
                        UserModel userdata = UserModel.fromjson(
                            snapshot.data!.data() as Map<String, dynamic>);
                        return Padding(
                          padding: EdgeInsets.only(
                              left: width * 0.04,
                              right: width * 0.06,
                              top: height * 0.02,
                              bottom: height * 0.02),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                splashColor: Colors.transparent,
                                borderRadius: BorderRadius.circular(100),
                                onTap: () {
                                  Get.to(ProfileScreen());
                                },
                                child: Container(
                                    height: height * 0.054,
                                    width: width * 0.12,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.network(
                                        userdata.imageUrl,
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                              ),
                              Container(
                                // margin: EdgeInsets.only(left: width * 0.03),
                                child: TextFormField(
                                  onTap: () {
                                    Get.to(CreatePostScreen(
                                      userDetail: userdata,
                                    ));
                                  },
                                  keyboardType: TextInputType.none,
                                  showCursor: false,
                                  decoration: InputDecoration(
                                      constraints: BoxConstraints(
                                        maxHeight: height * 0.044,
                                        maxWidth: width * 0.63,
                                      ),
                                      contentPadding: EdgeInsets.only(
                                          left: width * 0.06,
                                          top: height * 0.02),
                                      hintText: "What's on your mind?",
                                      hintStyle: TextStyle(color: Colors.black),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(30))),
                                ),
                              ),
                              InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                borderRadius: BorderRadius.circular(100),
                                onTap: () async {
                                  await data.pickPostImageFromGallery();
                                  Get.to(CreatePostScreen(
                                    userDetail: userdata,
                                  ));
                                },
                                child: Container(
                                  child: Icon(
                                    Icons.photo_library_rounded,
                                    size: 25,
                                    color: Color.fromARGB(255, 227, 97, 41),
                                  ),
                                ),
                              )
                            ],
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Icon(
                            Icons.error_outline_rounded,
                            size: 40,
                            color: Color.fromARGB(255, 227, 97, 41),
                          ),
                        );
                      }
                      return Container();
                    }),
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
                        return Expanded(
                          child: SingleChildScrollView(
                            child: Container(
                              child: ListView.builder(
                                itemCount: snapshot.data!.length,
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemBuilder: (BuildContext context, index) {
                                  PostModel screenData = snapshot.data![index];

                                  return Container(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: width * 0.04),
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
                                                            BorderRadius
                                                                .circular(100),
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(100),
                                                        child: Image.network(
                                                          screenData
                                                              .profileImage,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      )),
                                                  SizedBox(
                                                    width: width * 0.03,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
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
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    28,
                                                                    70,
                                                                    130)),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(
                                                    bottom: height * 0.025),
                                                child: IconButton(
                                                    splashColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
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
                                              Text(
                                                "1.2K",
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              Text(
                                                "42 comments",
                                                style: TextStyle(
                                                    color: Colors.grey),
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
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () {},
                                                child: Container(
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .thumb_up_alt_outlined,
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
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () {
                                                  Get.to(CommentScreen(
                                                    detail: screenData,
                                                  ));
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
                              ),
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Icon(
                            Icons.error_outline_rounded,
                            size: 40,
                            color: Color.fromARGB(255, 227, 97, 41),
                          ),
                        );
                      }

                      return Container();
                    }),
              ],
            );
          },
        )));
  }
}
