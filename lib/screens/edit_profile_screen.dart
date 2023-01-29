// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exd_social/controller/edit_profile_controller.dart';
import 'package:exd_social/database/firebase_auth.dart';
import 'package:exd_social/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel detail;
  const EditProfileScreen({Key? key, required this.detail}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController genderController = TextEditingController();
  TextEditingController homeTownController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  User? currentuser = FirebaseAuth.instance.currentUser;
  Future updateProfile() async {
    DocumentReference user = Auth.userRefernce.doc(currentuser!.uid);
    await user.update({
      "phone": phoneController.text,
      "homeTown": homeTownController.text,
      "birthday": dateOfBirthController.text,
      "gender": genderController.text,
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    genderController.text = widget.detail.gender;
    homeTownController.text = widget.detail.homeTown;
    dateOfBirthController.text = widget.detail.birthday;
    phoneController.text = widget.detail.phone;
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
            "Edit Profile",
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
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            updateProfile();
            Navigator.pop(context);
          },
          backgroundColor: Color.fromARGB(255, 227, 97, 41),
          child: Icon(
            Icons.upload_rounded,
            color: Colors.white,
            size: 25,
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                child: GetBuilder<EditProfileController>(
          init: EditProfileController(),
          initState: (_) {},
          builder: (data) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Stack(
                      children: [
                        data.coverImageFile != null
                            ? Container(
                                height: height * 0.25,
                                width: width,
                                // color: Colors.red,
                                child: Image.file(
                                  data.coverImageFile!,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Container(
                                height: height * 0.25,
                                width: width,
                                // color: Colors.red,
                                child: Image.network(
                                  widget.detail.metadata.coverImageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                        /////// cover image button
                        Padding(
                          padding: EdgeInsets.only(
                              left: width * 0.85, top: height * 0.18),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20))),
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        ListTile(
                                          onTap: () {
                                            data.pickCoverImageFromCamera();
                                            Navigator.pop(context);
                                          },
                                          minLeadingWidth: 20,
                                          leading: Icon(
                                            Icons.camera_alt_outlined,
                                            color: Color.fromARGB(
                                                255, 227, 97, 41),
                                            size: 25,
                                          ),
                                          title: Text(
                                            "Capture picture",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Color.fromARGB(
                                                    255, 227, 97, 41)),
                                          ),
                                        ),
                                        ListTile(
                                          onTap: () {
                                            data.pickCoverImageFromGallery();
                                            Navigator.pop(context);
                                          },
                                          minLeadingWidth: 20,
                                          leading: Icon(
                                            Icons.photo_library_rounded,
                                            color: Color.fromARGB(
                                                255, 227, 97, 41),
                                            size: 25,
                                          ),
                                          title: Text(
                                            "Select picture",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Color.fromARGB(
                                                    255, 227, 97, 41)),
                                          ),
                                        )
                                      ],
                                    );
                                  });
                            },
                            child: Container(
                              height: height * 0.055,
                              width: width * 0.13,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(255, 232, 233, 237),
                              ),
                              child: Icon(
                                Icons.camera_alt_rounded,
                                color: Colors.black,
                                size: 25,
                              ),
                            ),
                          ),
                        ),
                        data.imageFile != null
                            ? Container(
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
                                  // color: Colors.green,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.file(
                                    data.imageFile!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : Container(
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
                                  // color: Colors.green,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.network(
                                    widget.detail.imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                        ///// profile image button
                        Padding(
                          padding: EdgeInsets.only(
                              left: width * 0.32, top: height * 0.25),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20))),
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      // ignore: prefer_const_literals_to_create_immutables
                                      children: [
                                        ListTile(
                                          onTap: () {
                                            data.pickProfileImageFromCamera();
                                            Navigator.pop(context);
                                          },
                                          minLeadingWidth: 20,
                                          leading: Icon(
                                            Icons.camera_alt_outlined,
                                            color: Color.fromARGB(
                                                255, 227, 97, 41),
                                            size: 25,
                                          ),
                                          title: Text(
                                            "Capture picture",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Color.fromARGB(
                                                    255, 227, 97, 41)),
                                          ),
                                        ),
                                        ListTile(
                                          onTap: () {
                                            data.pickProfileImageFromGallery();
                                            Navigator.pop(context);
                                          },
                                          minLeadingWidth: 20,
                                          leading: Icon(
                                            Icons.photo_library_rounded,
                                            color: Color.fromARGB(
                                                255, 227, 97, 41),
                                            size: 25,
                                          ),
                                          title: Text(
                                            "Select picture",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Color.fromARGB(
                                                    255, 227, 97, 41)),
                                          ),
                                        )
                                      ],
                                    );
                                  });
                            },
                            child: Container(
                              height: height * 0.055,
                              width: width * 0.13,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(255, 232, 233, 237),
                              ),
                              child: Icon(
                                Icons.camera_alt_rounded,
                                color: Colors.black,
                                size: 25,
                              ),
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
                    child: Container(
                      child: Text(
                        widget.detail.firstName,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 26),
                      ),
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
                              color: Color.fromARGB(255, 232, 233, 237)),
                          child: Icon(
                            Icons.email_rounded,
                            color: Colors.black,
                            size: 22,
                          ),
                        ),
                        title: Text(
                          widget.detail.metadata.email,
                          style: TextStyle(color: Colors.black, fontSize: 16),
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
                              color: Color.fromARGB(255, 232, 233, 237)),
                          child: Icon(
                            Icons.call,
                            color: Colors.black,
                            size: 22,
                          ),
                        ),
                        title: TextFormField(
                          controller: phoneController,
                          // autofocus: true,
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          maxLines: null,
                          textCapitalization: TextCapitalization.words,
                          cursorColor: Color.fromARGB(255, 227, 97, 41),
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "03004567889",
                              hintStyle: TextStyle(fontSize: 16)),
                        ),
                        subtitle: Text(
                          "Phone",
                          style: TextStyle(
                              color: Color.fromARGB(255, 227, 97, 41),
                              fontSize: 14),
                        ),
                        trailing: InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {},
                            child: Icon(
                              Icons.edit,
                              size: 25,
                              color: Color.fromARGB(166, 158, 158, 158),
                            )),
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
                              color: Color.fromARGB(255, 232, 233, 237)),
                          child: Icon(
                            Icons.person,
                            color: Colors.black,
                            size: 22,
                          ),
                        ),
                        title: TextFormField(
                          controller: genderController,
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          maxLines: null,
                          textCapitalization: TextCapitalization.words,
                          cursorColor: Color.fromARGB(255, 227, 97, 41),
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Male",
                              hintStyle: TextStyle(fontSize: 16)),
                        ),
                        subtitle: Text(
                          "Gender",
                          style: TextStyle(
                              color: Color.fromARGB(255, 227, 97, 41),
                              fontSize: 14),
                        ),
                        trailing: InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {},
                            child: Icon(
                              Icons.edit,
                              size: 25,
                              color: Color.fromARGB(166, 158, 158, 158),
                            )),
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
                              color: Color.fromARGB(255, 232, 233, 237)),
                          child: Icon(
                            Icons.cake_rounded,
                            color: Colors.black,
                            size: 22,
                          ),
                        ),
                        title: TextFormField(
                          controller: dateOfBirthController,
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          maxLines: null,
                          textCapitalization: TextCapitalization.words,
                          cursorColor: Color.fromARGB(255, 227, 97, 41),
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "12-04-2000",
                              hintStyle: TextStyle(fontSize: 16)),
                        ),
                        subtitle: Text(
                          "Birthday",
                          style: TextStyle(
                              color: Color.fromARGB(255, 227, 97, 41),
                              fontSize: 14),
                        ),
                        trailing: InkWell(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              var pickDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1970),
                                lastDate: DateTime(2050),
                                builder: (context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: ColorScheme.light(
                                        primary: Color.fromARGB(
                                            255, 227, 97, 41), // <-- SEE HERE
                                        onPrimary: Colors.black, // <-- SEE HERE
                                        onSurface: Colors.grey, // <-- SEE HERE
                                      ),
                                      textButtonTheme: TextButtonThemeData(
                                        style: TextButton.styleFrom(
                                          primary: Color.fromARGB(255, 227, 97,
                                              41), // button text color
                                        ),
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );

                              if (pickDate != null) {
                                setState(() {
                                  dateOfBirthController.text =
                                      DateFormat("dd-MM-yyyy").format(pickDate);
                                });
                              }
                            },
                            child: Icon(
                              Icons.calendar_today_rounded,
                              size: 25,
                              color: Color.fromARGB(166, 158, 158, 158),
                            )),
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
                                color: Color.fromARGB(255, 232, 233, 237)),
                            child: Icon(
                              Icons.home_rounded,
                              color: Colors.black,
                              size: 22,
                            ),
                          ),
                          title: TextFormField(
                            controller: homeTownController,
                            style: TextStyle(color: Colors.black, fontSize: 16),
                            maxLines: null,
                            textCapitalization: TextCapitalization.sentences,
                            cursorColor: Color.fromARGB(255, 227, 97, 41),
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Shadman",
                                hintStyle: TextStyle(fontSize: 16)),
                          ),
                          subtitle: Container(
                            child: Text(
                              "Home town",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 227, 97, 41),
                                  fontSize: 14),
                            ),
                          ),
                          trailing: InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {},
                              child: Icon(
                                Icons.edit,
                                size: 25,
                                color: Color.fromARGB(166, 158, 158, 158),
                              )),
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
                                color: Color.fromARGB(255, 232, 233, 237)),
                            child: Icon(
                              Icons.location_on_rounded,
                              color: Colors.black,
                              size: 22,
                            ),
                          ),
                          title: Text(
                            "Shadman Market",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          subtitle: Text(
                            "Last Location",
                            style: TextStyle(
                                color: Color.fromARGB(255, 227, 97, 41),
                                fontSize: 14),
                          ),
                          trailing: InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {},
                              child: Icon(
                                Icons.edit,
                                size: 25,
                                color: Color.fromARGB(166, 158, 158, 158),
                              )),
                        ),
                      ]),
                  SizedBox(
                    height: height * 0.07,
                  )
                ]);
          },
        ))));
  }
}
