import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class TokenController extends GetxController {
  String? token;
  getFCMToken() async {
    token = await FirebaseMessaging.instance.getToken();
    print("FCM token: $token");
  }
}
