// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exd_social/controller/create_post_screen_controller.dart';
import 'package:exd_social/models/post_model.dart';
import 'package:exd_social/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:get/get.dart';

import '../database/firebase_auth.dart';

class CreatePostScreen extends StatefulWidget {
  final UserModel userDetail;
  CreatePostScreen({Key? key, required this.userDetail}) : super(key: key);

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen>
    with TickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return GetBuilder<CreatePostScreenController>(
      init: CreatePostScreenController(),
      initState: (_) {},
      builder: (data) {
        return Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: true,
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionBubble(
            // Menu items
            items: <Bubble>[
              Bubble(
                title: "Capture picture",
                iconColor: Color.fromARGB(255, 227, 97, 41),
                bubbleColor: Colors.white,
                icon: Icons.camera_alt_outlined,
                titleStyle: TextStyle(
                    fontSize: 16, color: Color.fromARGB(255, 227, 97, 41)),
                onPress: () {
                  data.pickPostImageFromCamera();
                  _animationController.reverse();
                },
              ),
              Bubble(
                title: "Select picture",
                iconColor: Color.fromARGB(255, 227, 97, 41),
                bubbleColor: Colors.white,
                icon: Icons.photo_library_rounded,
                titleStyle: TextStyle(
                    fontSize: 16, color: Color.fromARGB(255, 227, 97, 41)),
                onPress: () {
                  data.pickPostImageFromGallery();
                  _animationController.reverse();
                },
              ),
            ],

            // animation controller
            animation: _animation,

            // On pressed change animation state
            onPress: () => _animationController.isCompleted
                ? _animationController.reverse()
                : _animationController.forward(),

            // Floating Action button Icon color
            iconColor: Colors.white,

            // Flaoting Action button Icon
            iconData: Icons.add_a_photo_outlined,
            backGroundColor: Color.fromARGB(255, 227, 97, 41),
          ),
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.white,
                statusBarIconBrightness: Brightness.dark),
            backgroundColor: Colors.white,
            elevation: 1,
            shadowColor: Color.fromARGB(255, 227, 97, 41),
            title: Text(
              'Create post',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            leading: InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_ios_new_rounded,
                    color: Color.fromARGB(255, 227, 97, 41))),
            actions: [
              IconButton(
                  splashColor: Colors.transparent,
                  onPressed: () {
                    data.addPost();
                    Get.back();
                  },
                  icon: Icon(
                    Icons.send_rounded,
                    color: Color.fromARGB(255, 227, 97, 41),
                  ))
            ],
          ),
          body: SafeArea(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: width * 0.05,
                    right: width * 0.03,
                    top: height * 0.03,
                    bottom: height * 0.01),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: height * 0.054,
                      width: width * 0.12,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          widget.userDetail.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.03,
                    ),
                    Text(
                      widget.userDetail.firstName,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.05,
                            right: width * 0.05,
                            // top: height * 0.02,
                            bottom: height * 0.02),
                        child: Container(
                          width: width,
                          child: TextFormField(
                            controller: data.postTextController,
                            style: TextStyle(color: Colors.black, fontSize: 18),
                            maxLines: null,
                            textCapitalization: TextCapitalization.sentences,
                            cursorColor: Color.fromARGB(255, 28, 70, 130),

                            // keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "What's on your mind?",
                                hintStyle: TextStyle(fontSize: 22)),
                          ),
                        ),
                      ),
                      data.imageFile != null
                          ? Container(
                              width: width,
                              height: height * 0.5,
                              child: Image.file(
                                data.imageFile!,
                                fit: BoxFit.fitWidth,
                              ))
                          : Container()
                    ],
                  ),
                ),
              )
            ],
          )),
        );
      },
    );
  }
}
