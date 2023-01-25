// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exd_social/controller/singup_screen_controller.dart';
import 'package:exd_social/database/firebase_auth.dart';
import 'package:exd_social/screens/chat/util.dart';
import 'package:exd_social/screens/home_screen.dart';
import 'package:exd_social/screens/login_screen.dart';
import 'package:exd_social/screens/post_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../models/user_model.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({super.key});

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  User? currentUser = FirebaseAuth.instance.currentUser;
  bool passwordVisible = true;
  CollectionReference userRefernce =
      FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark),
        child: GetBuilder<SignUpScreenController>(
          init: SignUpScreenController(),
          initState: (_) {},
          builder: (data) {
            return Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.white,
              body: SafeArea(
                  child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.1),
                    Container(
                      child: Stack(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            data.imageFile != null
                                ? Container(
                                    height: height * 0.14,
                                    width: width * 0.3,
                                    decoration: BoxDecoration(
                                        // borderRadius: BorderRadius.circular(100),
                                        shape: BoxShape.circle,
                                        // border: Border.all(
                                        //     width: 2, color: Color.fromARGB(255, 227, 97, 41)),
                                        color:
                                            Color.fromARGB(39, 158, 158, 158)),
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.file(
                                          data.imageFile!,
                                          fit: BoxFit.cover,
                                        )),
                                  )
                                : Container(
                                    height: height * 0.14,
                                    width: width * 0.3,
                                    decoration: BoxDecoration(
                                        // borderRadius: BorderRadius.circular(100),
                                        shape: BoxShape.circle,
                                        // border: Border.all(
                                        //     width: 2, color: Color.fromARGB(255, 227, 97, 41)),
                                        color:
                                            Color.fromARGB(39, 158, 158, 158)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Icon(
                                        Icons.add_a_photo_outlined,
                                        size: 35,
                                        color: Color.fromARGB(255, 227, 97, 41),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            data.pickUserImage();
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                left: width * 0.56, top: height * 0.08),
                            height: height * 0.05,
                            width: width * 0.1,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 232, 233, 237),
                                shape: BoxShape.circle),
                            child: Icon(
                              Icons.add,
                              color: Colors.black,
                              size: 25,
                            ),
                          ),
                        )
                      ]),
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                child: Text(
                              "Welcome!",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 227, 97, 41),
                              ),
                            )),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Container(
                                child: Text(
                              "Create your account",
                              style: TextStyle(
                                fontSize: 15,
                                // fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 227, 97, 41),
                              ),
                            )),
                            Stack(children: [
                              Container(
                                margin: EdgeInsets.only(
                                    top: height * 0.03, left: width * 0.01),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Colors.transparent.withOpacity(0.15),
                                      spreadRadius: -1,
                                      blurRadius: 20,
                                      offset: Offset(0.0,
                                          0.75), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: TextFormField(
                                  controller: data.nameController,
                                  keyboardType: TextInputType.name,
                                  textCapitalization: TextCapitalization.words,
                                  cursorColor: Color.fromARGB(255, 227, 97, 41),
                                  decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      border: InputBorder.none,
                                      constraints: BoxConstraints(
                                        maxHeight: height * 0.045,
                                        maxWidth: width * 0.63,
                                      ),
                                      contentPadding: EdgeInsets.only(
                                          left: width * 0.15,
                                          right: width * 0.05),
                                      hintText: "Full Name",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(30))),
                                ),
                              ),
                              Container(
                                height: height * 0.053,
                                width: width * 0.13,
                                // color: Colors.green,
                                margin: EdgeInsets.only(
                                  top: height * 0.025,
                                ),

                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Colors.transparent.withOpacity(0.2),
                                      spreadRadius: 0,
                                      blurRadius: 3,
                                      offset: Offset(0.0,
                                          0.75), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.person_rounded,
                                  color: Color.fromARGB(255, 227, 97, 41),
                                  size: 22,
                                ),
                              ),
                            ]),
                            Stack(children: [
                              Container(
                                margin: EdgeInsets.only(
                                    top: height * 0.03, left: width * 0.01),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Colors.transparent.withOpacity(0.15),
                                      spreadRadius: -1,
                                      blurRadius: 20,
                                      offset: Offset(0.0,
                                          0.75), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: TextFormField(
                                  controller: data.emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  textCapitalization: TextCapitalization.none,
                                  cursorColor: Color.fromARGB(255, 227, 97, 41),
                                  decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      border: InputBorder.none,
                                      constraints: BoxConstraints(
                                        maxHeight: height * 0.045,
                                        maxWidth: width * 0.63,
                                      ),
                                      contentPadding: EdgeInsets.only(
                                          left: width * 0.15,
                                          right: width * 0.05),
                                      hintText: "Email",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(30))),
                                ),
                              ),
                              Container(
                                height: height * 0.053,
                                width: width * 0.13,
                                // color: Colors.green,
                                margin: EdgeInsets.only(
                                  top: height * 0.025,
                                ),

                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Colors.transparent.withOpacity(0.2),
                                      spreadRadius: 0,
                                      blurRadius: 3,
                                      offset: Offset(0.0,
                                          0.75), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.email_rounded,
                                  color: Color.fromARGB(255, 227, 97, 41),
                                  size: 22,
                                ),
                              ),
                            ]),
                            Stack(children: [
                              Container(
                                margin: EdgeInsets.only(
                                    top: height * 0.03, left: width * 0.01),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Colors.transparent.withOpacity(0.15),
                                      spreadRadius: -1,
                                      blurRadius: 20,
                                      offset: Offset(0.0,
                                          0.75), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: TextFormField(
                                  controller: data.passwordController,
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: passwordVisible,
                                  cursorColor: Color.fromARGB(255, 227, 97, 41),
                                  decoration: InputDecoration(
                                      suffixIcon: InkWell(
                                          splashColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () {
                                            setState(() {
                                              passwordVisible =
                                                  !passwordVisible;
                                            });
                                          },
                                          child: Icon(
                                            passwordVisible
                                                ? Icons.visibility_off_rounded
                                                : Icons.visibility_rounded,
                                            color: Color.fromARGB(
                                                255, 227, 97, 41),
                                          )),
                                      fillColor: Colors.white,
                                      filled: true,
                                      border: InputBorder.none,
                                      constraints: BoxConstraints(
                                        maxHeight: height * 0.045,
                                        maxWidth: width * 0.63,
                                      ),
                                      contentPadding:
                                          EdgeInsets.only(left: width * 0.15),
                                      hintText: "Password",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(30))),
                                ),
                              ),
                              Container(
                                height: height * 0.053,
                                width: width * 0.13,
                                // color: Colors.green,
                                margin: EdgeInsets.only(
                                  top: height * 0.025,
                                ),

                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Colors.transparent.withOpacity(0.2),
                                      spreadRadius: 0,
                                      blurRadius: 3,
                                      offset: Offset(0.0,
                                          0.75), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.lock_rounded,
                                  color: Color.fromARGB(255, 227, 97, 41),
                                  size: 22,
                                ),
                              ),
                            ]),
                            Stack(children: [
                              Container(
                                margin: EdgeInsets.only(
                                    top: height * 0.03, left: width * 0.01),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Colors.transparent.withOpacity(0.15),
                                      spreadRadius: -1,
                                      blurRadius: 20,
                                      offset: Offset(0.0,
                                          0.75), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: TextFormField(
                                  controller: data.phoneController,
                                  keyboardType: TextInputType.phone,
                                  cursorColor: Color.fromARGB(255, 227, 97, 41),
                                  decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      border: InputBorder.none,
                                      constraints: BoxConstraints(
                                        maxHeight: height * 0.045,
                                        maxWidth: width * 0.63,
                                      ),
                                      contentPadding: EdgeInsets.only(
                                          left: width * 0.15,
                                          right: width * 0.05),
                                      hintText: "Phone",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(30))),
                                ),
                              ),
                              Container(
                                height: height * 0.053,
                                width: width * 0.13,
                                // color: Colors.green,
                                margin: EdgeInsets.only(
                                  top: height * 0.025,
                                ),

                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Colors.transparent.withOpacity(0.2),
                                      spreadRadius: 0,
                                      blurRadius: 3,
                                      offset: Offset(0.0,
                                          0.75), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.phone,
                                  color: Color.fromARGB(255, 227, 97, 41),
                                  size: 22,
                                ),
                              ),
                            ]),
                            Stack(children: [
                              Container(
                                margin: EdgeInsets.only(
                                    top: height * 0.03, left: width * 0.01),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Colors.transparent.withOpacity(0.15),
                                      spreadRadius: -1,
                                      blurRadius: 20,
                                      offset: Offset(0.0,
                                          0.75), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: TextFormField(
                                  controller: data.genderController,
                                  keyboardType: TextInputType.name,
                                  textCapitalization: TextCapitalization.words,
                                  cursorColor: Color.fromARGB(255, 227, 97, 41),
                                  decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      border: InputBorder.none,
                                      constraints: BoxConstraints(
                                        maxHeight: height * 0.045,
                                        maxWidth: width * 0.63,
                                      ),
                                      contentPadding: EdgeInsets.only(
                                          left: width * 0.15,
                                          right: width * 0.05),
                                      hintText: "Gender",
                                      hintStyle: TextStyle(color: Colors.grey),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              width: 1, color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(30))),
                                ),
                              ),
                              Container(
                                height: height * 0.053,
                                width: width * 0.13,
                                // color: Colors.green,
                                margin: EdgeInsets.only(
                                  top: height * 0.025,
                                ),

                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Colors.transparent.withOpacity(0.2),
                                      spreadRadius: 0,
                                      blurRadius: 3,
                                      offset: Offset(0.0,
                                          0.75), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.person_rounded,
                                  color: Color.fromARGB(255, 227, 97, 41),
                                  size: 22,
                                ),
                              ),
                            ]),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: height * 0.04,
                          left: width * 0.33,
                          right: width * 0.33),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          await Auth.signUpUser(
                            email: data.emailController.text,
                            password: data.passwordController.text,
                            fullName: data.nameController.text,
                            phoneNumber: data.phoneController.text,
                            gender: data.genderController.text,
                            imageUrl: data.imageUrl, birthday: 'N/A',
                            coverImageUrl: '', homeTown: 'N/A',
                            // profileImage: '',
                            // profileImage: data.profileImageUrl,
                          );
                          await data.getUserImage();

                          Get.offAll(LoginScreen());
                          data.emailController.clear();
                          data.passwordController.clear();
                          data.nameController.clear();
                          data.phoneController.clear();
                          data.genderController.clear();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: height * 0.05,
                          width: width,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 227, 97, 41),
                              borderRadius: BorderRadius.circular(30)),
                          child: Text(
                            "Sign up",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.02),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account?",
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                          SizedBox(
                            width: width * 0.01,
                          ),
                          InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                Get.to(LoginScreen());
                              },
                              child: Text(
                                "SignIn",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 227, 97, 41)),
                              ))
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                  ],
                ),
              )),
            );
          },
        ));
  }
}































// await Auth.signUpUser(
                      //   email: data.emailController.text,
                      //   password: data.passwordController.text,
                      //   fullName: data.nameController.text,
                      //   phoneNumber: data.phoneController.text,
                      //   gender: data.genderController.text,
                      // );
                      // await data.getUserImage();

                      // Get.to(LoginScreen());
                      // data.emailController.clear();
                      // data.passwordController.clear();
                      // data.nameController.clear();
                      // data.phoneController.clear();
                      // data.genderController.clear();