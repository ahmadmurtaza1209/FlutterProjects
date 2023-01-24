import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  late String id;
  late final String postText;
  late final String uid;
  late final String profileImage;
  late final String postImage;
  late final String dateTime;
  late final int likesCount;
  late final int commentsCount;
  late final String userName;
  // default constructor
  PostModel(
      {required this.uid,
      required this.id,
      required this.postText,
      required this.profileImage,
      required this.postImage,
      required this.dateTime,
      required this.likesCount,
      required this.commentsCount,
      required this.userName});

  // for post creation
  PostModel.withoutId(
      {required this.uid,
      // required this.id,
      required this.postText,
      required this.profileImage,
      required this.postImage,
      required this.dateTime,
      required this.userName});
  // when we read data from firebase this will be used for converting DocumentSnapshot to model object
  PostModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot.id;
    uid = documentSnapshot["uid"];
    postText = documentSnapshot["postText"];
    postImage = documentSnapshot["postImage"] ?? "";
    profileImage = documentSnapshot["profileImage"];
    userName = documentSnapshot["userName"] ?? "";

    dateTime = documentSnapshot["dateTime"] ?? DateTime.now().toString();
  }
  PostModel.fromjson(Map<String, dynamic> data, String id) {
    uid = data["uid"];
    id = id;
    userName = data["userName"] ?? "";
    postText = data["postText"] ?? "";
    postImage = data["postImage"] ?? "";
    profileImage = data["profileImage"] ?? "";
    likesCount = data["likesCount"] ?? 0;
    commentsCount = data["commentsCount"] ?? 0;
    dateTime = data["dateTime"] ?? DateTime.now().toString();
  }
  // this will be used to convert PostModelNew.withoutId to Map<String,dynamic>
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['uid'] = uid;
    data['postText'] = postText;
    data['postImage'] = postImage;
    data['profileImage'] = profileImage;
    data['dateTime'] = dateTime;
    data["userName"] = userName;
    // data["id"] = id;

    return data;
  }
}
