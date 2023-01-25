import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exd_social/screens/chat/login.dart';
import 'package:exd_social/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:get/get.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class Auth {
  static CollectionReference userRefernce =
      FirebaseFirestore.instance.collection("users");

  static Future signUpUser({
    required String email,
    required String password,
    required String fullName,
    required String phoneNumber,
    required String gender,
    required String homeTown,
    required String birthday,
    required String imageUrl,
    required String coverImageUrl,
    // required String gender
  }) async {
    bool status = false;

    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? currentUser = credential.user;
      if (currentUser != null) {
        Map<String, dynamic> userProfiledata = {
          "name": fullName,
          "phone": phoneNumber,
          "email": email,
          "uid": credential.user!.uid,

          // "country": country,
          // "province": province,
          "gender": gender,
          "homeTown": homeTown,
          "birthday": birthday,
          "coverImage": coverImageUrl
        };
        await FirebaseChatCore.instance.createUserInFirestore(
          types.User(
              firstName: fullName,
              id: credential.user!.uid,
              imageUrl: imageUrl,
              metadata: userProfiledata),
        );
        DocumentReference currentUserRefernce =
            userRefernce.doc(currentUser.uid);

        // await currentUserRefernce.set(userProfiledata);
      }

      status = true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  static Future loginUser(
      {required String email, required String password}) async {
    bool status = false;
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      status = true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    return status;
  }

  static Future logoutUser() async {
    await FirebaseAuth.instance.signOut();
    Get.to(LoginScreen());
  }
}
