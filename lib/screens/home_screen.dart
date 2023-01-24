import 'package:exd_social/database/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text("Home Screen"),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Auth.logoutUser();
                },
                child: Text("LogOut"))
          ],
        ),
        body: Center(
          child: Text("welcome"),
        ));
  }
}
