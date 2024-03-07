import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_tech_lib/services/models/responseAPI_model.dart';
import 'package:my_tech_lib/services/repositories/user_repository.dart';
import 'package:my_tech_lib/views/navigator/navigator.dart';
import 'package:my_tech_lib/views/splash_screen.dart';
import 'services/models/user_model.dart';
import 'views/auth/login_page_screen.dart';

class MainScreen extends StatefulWidget {
  MainScreen(this.uuidUser, {Key? key}) : super(key: key);
  String? uuidUser;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late bool load;
  int state = -1;
  UserModel? user;

  @override
  void initState() {
    super.initState();
    startTime();
  }

  initUser() async {
    ResponseApi? response = await UserRepository().getUser(context,widget.uuidUser!);
    if (response != null && response.status == 200) {
      UserModel result = UserModel.fromJson(response.body);
      user = result;
    }

  }

  startTime() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, verify_pages);
  }

  verify_pages() async {
    if (!mounted) return;

    if (widget.uuidUser == null) {
      setState(() {
        state = 1;
      });
    } else {
      await initUser();
      if (user != null) {
        setState(() {
          state = 2;
        });
      }
    }
  }

    @override
    Widget build(BuildContext context) {
      start_page() {
        switch (state) {
          case (1):
            return const LoginPageWidget();
          case (2):
            return NavBarPage(user!);
          default:
            return const SplashScreen();
        }
      }

      return WillPopScope(onWillPop: () async => false, child: start_page());
    }
  }
