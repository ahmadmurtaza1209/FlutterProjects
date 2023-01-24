// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exd_social/models/comment_model.dart';
import 'package:exd_social/models/post_model.dart';
import 'package:exd_social/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CommentScreen extends StatefulWidget {
  final PostModel detail;
  const CommentScreen({
    Key? key,
    required this.detail,
  }) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  TextEditingController commentController = TextEditingController();
  User? currentuser = FirebaseAuth.instance.currentUser;
  CollectionReference postReference =
      FirebaseFirestore.instance.collection("post");
  CollectionReference commentReference =
      FirebaseFirestore.instance.collection("comment");
  CollectionReference userRefernce =
      FirebaseFirestore.instance.collection("users");
  Future addComment() async {
    DocumentSnapshot user = await userRefernce.doc(currentuser!.uid).get();
    UserModel userData =
        UserModel.fromjson(user.data() as Map<String, dynamic>);

    CommentModel commentData = CommentModel(
        commentText: commentController.text,
        dateTime: DateTime.now().toString(),
        profileImage: userData.imageUrl,
        userName: userData.firstName,
        userId: currentuser!.uid,
        postId: widget.detail.id);
    await commentReference
        .add(commentData.tojson())
        .then((value) => print("successfully add comment"))
        .onError((error, stackTrace) => print("failed"));
  }

  Stream<List<CommentModel>> getComment() async* {
    List<CommentModel> commentList = [];
    QuerySnapshot ref = await commentReference
        .where("postId", isEqualTo: widget.detail.id)
        .get();
    for (var i = 0; i < ref.docs.length; i++) {
      CommentModel comment =
          CommentModel.fromjson(ref.docs[i].data() as Map<String, dynamic>);
      commentList.add(comment);
    }
    yield commentList;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
          "Comments",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: InkWell(
          splashColor: Colors.transparent,
          borderRadius: BorderRadius.circular(100),
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color.fromARGB(255, 227, 97, 41),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // color: Colors.amber,
                margin: EdgeInsets.only(top: height * 0.01),
                child: ListTile(
                  leading: Container(
                      height: height * 0.054,
                      width: width * 0.12,
                      decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(100),
                          shape: BoxShape.circle,
                          color: Colors.green),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          widget.detail.profileImage,
                          fit: BoxFit.cover,
                        ),
                      )),
                  title: TextFormField(
                    controller: commentController,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    maxLines: null,
                    textCapitalization: TextCapitalization.sentences,
                    cursorColor: Color.fromARGB(255, 227, 97, 41),
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Add a comment...",
                        hintStyle: TextStyle(fontSize: 16)),
                  ),
                  trailing: InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {
                      addComment();
                      Get.back();
                    },
                    child: Icon(
                      Icons.send_rounded,
                      color: Color.fromARGB(255, 227, 97, 41),
                    ),
                  ),
                ),
              ),
              Divider(
                height: height * 0.02,
                thickness: 1,
                color: Color.fromARGB(255, 227, 97, 41),
              ),
              StreamBuilder(
                  stream: getComment(),
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
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, index) {
                            CommentModel screenData = snapshot.data![index];
                            return Padding(
                              padding: EdgeInsets.only(left: width * 0.01),
                              child: ListTile(
                                horizontalTitleGap: 8,
                                leading: Container(
                                  height: height * 0.037,
                                  width: width * 0.08,
                                  decoration: BoxDecoration(
                                      // color: Colors.red,
                                      // borderRadius: BorderRadius.circular(100)
                                      shape: BoxShape.circle),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.network(
                                      screenData.profileImage,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  screenData.userName,
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Color.fromARGB(255, 227, 97, 41),
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  screenData.commentText,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 16),
                                ),
                                trailing: Text(
                                  screenData.dateTime,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color.fromARGB(255, 227, 97, 41),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                            //
                          });
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
          ),
        ),
      ),
    );
  }
}
