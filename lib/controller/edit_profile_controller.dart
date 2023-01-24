import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../database/firebase_auth.dart';

class EditProfileController extends GetxController {
  TextEditingController genderController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  File? imageFile;
  File? coverImageFile;
  CroppedFile? cropFile;
  CroppedFile? coverCropFile;
  late String imageUrl = "";
  late String coverImageUrl = "";
  User? currentuser = FirebaseAuth.instance.currentUser;
  pickProfileImageFromGallery() async {
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
          .child("profileImages")
          .child("/$imageName");
      uploadTask = reference.putFile(filePath);

      Future.value(uploadTask).then((value) async {
        imageUrl = await reference.getDownloadURL();
        // User? currentUser = FirebaseAuth.instance.currentUser;
        // // Auth.userRefernce.doc(uid);
        DocumentReference user = Auth.userRefernce.doc(currentuser!.uid);
        await user.update({"imageUrl": imageUrl});
      });
    } catch (e) {
      print("errorr");
    }
  }

  // getPostImageFromGallery() async {

  // }

  pickProfileImageFromCamera() async {
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
          .child("profileImages")
          .child("/$imageName");
      uploadTask = reference.putFile(filePath);

      Future.value(uploadTask).then((value) async {
        imageUrl = await reference.getDownloadURL();

        // User? currentUser = FirebaseAuth.instance.currentUser;

        DocumentReference user = Auth.userRefernce.doc(currentuser!.uid);
        await user.update({"imageUrl": imageUrl});
      });
    } catch (e) {
      print("errorr");
    }
  }

  pickCoverImageFromGallery() async {
    final ImagePicker pick = ImagePicker();
    final XFile? image =
        await pick.pickImage(source: ImageSource.gallery, imageQuality: 30);
    coverCropFile = await ImageCropper().cropImage(sourcePath: image!.path);

    if (coverCropFile != null) {
      coverImageFile = File(coverCropFile!.path);
      update();
    }
    String imageName = DateTime.now().millisecondsSinceEpoch.toString();
    File filePath = File(coverImageFile!.path);
    try {
      firebase_storage.UploadTask? uploadTask;
      firebase_storage.Reference reference = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child("coverImages")
          .child("/$imageName");
      uploadTask = reference.putFile(filePath);

      Future.value(uploadTask).then((value) async {
        coverImageUrl = await reference.getDownloadURL();
        // User? currentUser = FirebaseAuth.instance.currentUser;
        // // Auth.userRefernce.doc(uid);
        DocumentReference user = Auth.userRefernce.doc(currentuser!.uid);
        await user.update({"coverImage": coverImageUrl});
      });
    } catch (e) {
      print("errorr");
    }
  }

  // getPostImageFromGallery() async {

  // }

  pickCoverImageFromCamera() async {
    final ImagePicker pick = ImagePicker();
    final XFile? image =
        await pick.pickImage(source: ImageSource.camera, imageQuality: 30);
    coverCropFile = await ImageCropper().cropImage(sourcePath: image!.path);

    if (coverCropFile != null) {
      coverImageFile = File(coverCropFile!.path);
      update();
    }
    String imageName = DateTime.now().millisecondsSinceEpoch.toString();
    File filePath = File(coverImageFile!.path);
    try {
      firebase_storage.UploadTask? uploadTask;
      firebase_storage.Reference reference = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child("coverImages")
          .child("/$imageName");
      uploadTask = reference.putFile(filePath);

      Future.value(uploadTask).then((value) async {
        coverImageUrl = await reference.getDownloadURL();

        // User? currentUser = FirebaseAuth.instance.currentUser;

        DocumentReference user = Auth.userRefernce.doc(currentuser!.uid);
        await user.update({"coverImage": coverImageUrl});
      });
    } catch (e) {
      print("errorr");
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }
}
