// // ignore_for_file: prefer_const_constructors

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:exd_social/models/user_model.dart';
// import 'package:exd_social/screens/chat_screen.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

// class AllUserScreen extends StatefulWidget {
//   const AllUserScreen({Key? key}) : super(key: key);

//   @override
//   State<AllUserScreen> createState() => _AllUserScreenState();
// }

// class _AllUserScreenState extends State<AllUserScreen> {
//   User? currentuser = FirebaseAuth.instance.currentUser;
//   CollectionReference userRefernce =
//       FirebaseFirestore.instance.collection("user");

//   Stream<List<UserModel>> getUser() async* {
//     List<UserModel> userList = [];
//     QuerySnapshot ref =
//         await userRefernce.where("uid", isNotEqualTo: currentuser!.uid).get();
//     for (var i = 0; i < ref.docs.length; i++) {
//       UserModel user = UserModel.fromjson(
//         ref.docs[i].data() as Map<String, dynamic>,
//       );
//       userList.add(user);
//     }
//     yield userList;
//   }

//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         systemOverlayStyle: SystemUiOverlayStyle(
//             statusBarColor: Colors.white,
//             statusBarIconBrightness: Brightness.dark),
//         backgroundColor: Colors.white,
//         elevation: 1,
//         shadowColor: Color.fromARGB(255, 227, 97, 41),
//         title: Text(
//           "Chats",
//           style: TextStyle(color: Colors.black),
//         ),
//         leading: InkWell(
//           splashColor: Colors.transparent,
//           onTap: () {
//             Get.back();
//           },
//           child: Icon(
//             Icons.arrow_back_ios_new_rounded,
//             color: Color.fromARGB(255, 227, 97, 41),
//           ),
//         ),
//       ),
//       body: SafeArea(
//           child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             StreamBuilder(
//                 stream: getUser(),
//                 builder: (BuildContext context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(
//                       child: Text(
//                         "Loading.....",
//                         style: TextStyle(
//                             color: Color.fromARGB(255, 28, 70, 130),
//                             fontSize: 18),
//                       ),
//                     );
//                   } else if (snapshot.hasData) {
//                     return Padding(
//                       padding: EdgeInsets.only(
//                           left: width * 0.05,
//                           right: width * 0.03,
//                           // top: height * 0.03,
//                           bottom: height * 0.03),
//                       child: ListView.builder(
//                           itemCount: snapshot.data!.length,
//                           shrinkWrap: true,
//                           physics: ScrollPhysics(),
//                           itemBuilder: (BuildContext context, index) {
//                             UserModel userData = snapshot.data![index];
//                             return InkWell(
//                               splashColor: Color.fromARGB(0, 255, 254, 254),
//                               onTap: () async {
//                                 User? currentuser =
//                                     FirebaseAuth.instance.currentUser;
//                                 DocumentSnapshot user = await userRefernce
//                                     .doc(currentuser!.uid)
//                                     .get();
//                                 UserModel data = UserModel.fromjson(
//                                     user.data() as Map<String, dynamic>);
//                                 var current_user = types.User(
//                                   id: data.userId,
//                                   firstName: data.fullName,
//                                   imageUrl: data.profileImage,
//                                 );

//                                 var receiver_user = types.User(
//                                   id: userData.userId,
//                                   firstName: userData.fullName,
//                                   imageUrl: userData.profileImage,
//                                 );

//                                 Get.to(ChatScreen(
//                                   receiverUser: receiver_user,
//                                   user: current_user,
//                                 ));
//                               },
//                               child: Container(
//                                 margin: EdgeInsets.only(top: height * 0.03),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Container(
//                                       height: height * 0.054,
//                                       width: width * 0.12,
//                                       decoration: BoxDecoration(
//                                         borderRadius:
//                                             BorderRadius.circular(100),
//                                       ),
//                                       child: ClipRRect(
//                                         borderRadius:
//                                             BorderRadius.circular(100),
//                                         child: Image.network(
//                                           userData.profileImage,
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(
//                                       width: width * 0.05,
//                                     ),
//                                     Text(
//                                       userData.fullName,
//                                       style: TextStyle(
//                                           color: Colors.black,
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 17),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           }),
//                     );
//                   } else if (snapshot.hasError) {
//                     return Center(
//                       child: Text("Error!!!!"),
//                     );
//                   }
//                   return Container();
//                 })
//           ],
//         ),
//       )),
//     );
//   }
// }
