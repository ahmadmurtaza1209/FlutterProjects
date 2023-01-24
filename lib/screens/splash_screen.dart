import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:exd_social/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark),
        child: AnimatedSplashScreen(
          // duration: 2000,
          animationDuration: Duration(seconds: 3),
          splashIconSize: 250,
          curve: Curves.easeInCirc,
          splash: Container(
            child: Image.asset(
              "Assets/images/splash.png",
              fit: BoxFit.cover,
            ),
          ),
          nextScreen: LoginScreen(),
          splashTransition: SplashTransition.fadeTransition,
          pageTransitionType: PageTransitionType.rightToLeft,
          backgroundColor: Colors.white,
        ));
  }
}
