// ignore_for_file: prefer_const_constructors

import 'package:exd_social/controller/login_screen_controller.dart';
import 'package:exd_social/database/firebase_auth.dart';
import 'package:exd_social/screens/post_screen.dart';
import 'package:exd_social/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool passwordVisible = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark),
        child: GetBuilder<LoginScreenController>(
          init: LoginScreenController(),
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
                    SizedBox(
                      height: height * 0.1,
                    ),
                    Container(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                // height: height * 0.19,
                                width: width * 0.8,
                                child: Image.asset(
                                  "Assets/images/splash.png",
                                  fit: BoxFit.fitHeight,
                                )),
                          ]),
                    ),
                    // SizedBox(
                    //   height: height * 0.02,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                child: Text(
                              "Welcome back!",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 227, 97, 41),
                              ),
                            )),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Container(
                                child: Text(
                              "Login to your account",
                              style: TextStyle(
                                fontSize: 14,
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
                                        maxWidth: width * 0.8,
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
                                  obscureText: passwordVisible,
                                  keyboardType: TextInputType.visiblePassword,
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
                                        maxWidth: width * 0.8,
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
                          bool status = await Auth.loginUser(
                              email: data.emailController.text,
                              password: data.passwordController.text);

                          status
                              ? Get.offAll(PostScreen())
                              : showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Alert"),
                                      content:
                                          Text("Invalid username and password"),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Okay",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ))
                                      ],
                                    );
                                  },
                                );
                          data.emailController.clear();
                          data.passwordController.clear();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: height * 0.05,
                          width: width,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 227, 97, 41),
                              borderRadius: BorderRadius.circular(30)),
                          child: Text(
                            "Sign in",
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
                            "Don't have an account?",
                            style: TextStyle(color: Colors.grey, fontSize: 15),
                          ),
                          SizedBox(
                            width: width * 0.01,
                          ),
                          InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                Get.to(SingUpScreen());
                              },
                              child: Text(
                                "SignUp",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 227, 97, 41)),
                              ))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.1,
                    )
                  ],
                ),
              )),
            );
          },
        ));
  }
}








//  bool status = await Auth.loginUser(
//                           email: data.emailController.text,
//                           password: data.passwordController.text);

//                       status
//                           ? Get.to(PostScreen())
//                           : showDialog(
//                               context: context,
//                               builder: (BuildContext context) {
//                                 return AlertDialog(
//                                   title: Text("Alert"),
//                                   content:
//                                       Text("Invalid username and password"),
//                                   actions: [
//                                     TextButton(
//                                         onPressed: () {
//                                           Navigator.pop(context);
//                                         },
//                                         child: Text(
//                                           "Okay",
//                                           style: TextStyle(color: Colors.black),
//                                         ))
//                                   ],
//                                 );
//                               },
//                             );
//                       data.emailController.clear();
//                       data.passwordController.clear