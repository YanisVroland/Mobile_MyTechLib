import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_tech_lib/views/splash_screen.dart';
import 'services/models/user.dart';
import 'views/auth/login_page_widget.dart';

class  MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
   _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static late UserData user_me;
  late bool load;
  int state = -1;

  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, verify_pages);
  }

  verify_pages() async {
    if (!mounted) return;
    // User? userId = FirebaseAuth.instance.currentUser;

    // if (userId == null) {
    if (true) {
      setState(() {
        state = 1;
      });
    } else {
      // FirebaseCrashlytics.instance.setUserIdentifier(userId.uid);
      // user_me = await userRepos.getUserInformations(userId.uid);
      setState(() {
        state = 2;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    start_page() {
      switch (state) {
        case (1):
          return const LoginPageWidget();
        // case (2):
        //   return NavBarPage();
        default:
          return const SplashScreen();
      }
    }

    return WillPopScope(onWillPop: () async => false, child: start_page());
  }
}
