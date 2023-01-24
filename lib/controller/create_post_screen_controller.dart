import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exd_social/models/post_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../database/firebase_auth.dart';
import '../models/user_model.dart';

class CreatePostScreenController extends GetxController {
  TextEditingController postTextController = TextEditingController();
  File? imageFile;

  CroppedFile? cropFile;

  late String postImageUrl = "";
  User? currentuser = FirebaseAuth.instance.currentUser;
  pickPostImageFromGallery() async {
    final ImagePicker pick = ImagePicker();
    final XFile? image =
        await pick.pickImage(source: ImageSource.gallery, imageQuality: 30);
    cropFile = await ImageCropper().cropImage(sourcePath: image!.path);

    if (cropFile != null) {
      imageFile = File(cropFile!.path);
      update();
    }
    String imageName = DateTime.now().millisecondsSinceEpoch.toString();
    File filePath = File(imageFile!.path);
    try {
      firebase_storage.UploadTask? uploadTask;
      firebase_storage.Reference reference = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child("postImages")
          .child("/$imageName");
      uploadTask = reference.putFile(filePath);

      Future.value(uploadTask).then((value) async {
        postImageUrl = await reference.getDownloadURL();
        // User? currentUser = FirebaseAuth.instance.currentUser;
        // // Auth.userRefernce.doc(uid);
        DocumentReference user = Auth.userRefernce.doc(currentUser!.uid);
        await user.update({"postImage": postImageUrl});
      });
    } catch (e) {
      print("errorr");
    }
  }

  // getPostImageFromGallery() async {

  // }

  pickPostImageFromCamera() async {
    final ImagePicker pick = ImagePicker();
    final XFile? image =
        await pick.pickImage(source: ImageSource.camera, imageQuality: 30);
    cropFile = await ImageCropper().cropImage(sourcePath: image!.path);

    if (cropFile != null) {
      imageFile = File(cropFile!.path);
      update();
    }
    String imageName = DateTime.now().millisecondsSinceEpoch.toString();
    File filePath = File(imageFile!.path);
    try {
      firebase_storage.UploadTask? uploadTask;
      firebase_storage.Reference reference = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child("postImages")
          .child("/$imageName");
      uploadTask = reference.putFile(filePath);

      Future.value(uploadTask).then((value) async {
        postImageUrl = await reference.getDownloadURL();

        // User? currentUser = FirebaseAuth.instance.currentUser;

        DocumentReference user = Auth.userRefernce.doc(currentUser!.uid);
        await user.update({"postImage": postImageUrl});
      });
    } catch (e) {
      print("errorr");
    }
  }

  // getPostImageFromCamera() async {

  // }

  User? currentUser = FirebaseAuth.instance.currentUser;
  CollectionReference postReference =
      FirebaseFirestore.instance.collection("post");
  CollectionReference userRefernce =
      FirebaseFirestore.instance.collection("users");
  Future addPost() async {
    CollectionReference postReference =
        FirebaseFirestore.instance.collection("post");
    // DocumentReference post =
    // FirebaseFirestore.instance.collection("post").doc(postReference.id);

    // QuerySnapshot post = await postReference.get();
    DocumentSnapshot user = await userRefernce.doc(currentUser!.uid).get();
    UserModel userdata =
        UserModel.fromjson(user.data() as Map<String, dynamic>);

    PostModel postData = PostModel.withoutId(
      uid: user.id,
      postText: postTextController.text,
      postImage: postImageUrl,
      dateTime: DateTime.now().toString(),
      profileImage: userdata.imageUrl,
      userName: userdata.firstName,
    );
    await postReference
        .add(postData.toJson())
        .then((value) => print("successfully add post"))
        .onError((error, stackTrace) => print("failed"));
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
