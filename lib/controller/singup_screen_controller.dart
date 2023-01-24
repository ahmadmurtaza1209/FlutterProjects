import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exd_social/database/firebase_auth.dart';
import 'package:exd_social/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

class SignUpScreenController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  File? imageFile;

  CroppedFile? cropFile;

  late String imageUrl = "";
  User? currentuser = FirebaseAuth.instance.currentUser;

  pickUserImage() async {
    final ImagePicker pick = ImagePicker();
    final XFile? image =
        await pick.pickImage(source: ImageSource.gallery, imageQuality: 30);
    cropFile = await ImageCropper().cropImage(sourcePath: image!.path);

    if (cropFile != null) {
      imageFile = File(cropFile!.path);
      update();
    }
  }

  getUserImage() async {
    String imageName = DateTime.now().millisecondsSinceEpoch.toString();
    File filePath = File(imageFile!.path);
    try {
      firebase_storage.UploadTask? uploadTask;
      firebase_storage.Reference reference = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child("profileImages")
          .child("/$imageName");
      uploadTask = reference.putFile(filePath);

      Future.value(uploadTask).then((value) async {
        imageUrl = await reference.getDownloadURL();
        User? currentUser = FirebaseAuth.instance.currentUser;
        // Auth.userRefernce.doc(uid);
        DocumentReference user = Auth.userRefernce.doc(currentUser!.uid);
        await user.update({"imageUrl": imageUrl});
      });
    } catch (e) {
      print("errorr");
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // getUserImage();
  }
}
