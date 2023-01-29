// ignore_for_file: prefer_const_constructors

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:exd_social/controller/token_controller.dart';
import 'package:exd_social/screens/login_screen.dart';
import 'package:exd_social/screens/signup_screen.dart';
import 'package:exd_social/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:page_transition/page_transition.dart';

TokenController controller = Get.put(TokenController());
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();
    print("Handling a background message: ${message.messageId}");
  }

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await controller.getFCMToken();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        Get.snackbar(
            "${message.notification!.title}", "${message.notification!.body}",
            backgroundColor: Color.fromARGB(255, 227, 97, 41).withOpacity(0.1));

        print(
            'Message also contained a notification: ${message.notification!.body}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false, home: SplashScreen());
  }
}
// Color.fromARGB(255, 227, 97, 41)   orange
// Color.fromARGB(255, 28, 70, 130)  blue
// dIsrLt6NRiCsn05gBUbQmg:APA91bHVUjU2udP82NbttolKeDoP_rCoBdXLGX6pGkYxImgLsf8ZkvptB5cwJ9BVP_P4mvmqQHbyKKbzzhOeyDjCRcH7ekol37tzCrP7RzIzU-DWqsBQjTjD6zw3tay7ENSd39LWWn0d







// csZftciTRcSJq9Du3g7yHa:APA91bGHejO_nAE89oDPWw9EA75YwtB2k7jMtnZqA4B-_mEu2hLCcjNDbhHpK9ZDTgWMlz8gTJ19k4qAMHy8sjG6T_vieVOc0uOdgFRnErfsD_0MYdv3msYNvk8-Us2k8yRwgTweU-d4