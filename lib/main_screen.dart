/*
  This class represents the main screen of the application.
  It handles the initialization of the user data and determines
  which page to display based on the user's authentication status.
*/

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_tech_lib/services/models/globalData_model.dart';
import 'package:my_tech_lib/services/models/responseAPI_model.dart';
import 'package:my_tech_lib/services/repositories/user_repository.dart';
import 'package:my_tech_lib/views/navigator/navigator.dart';
import 'package:my_tech_lib/views/splash_screen.dart';
import 'services/models/user_model.dart';
import 'views/auth/login_page_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen(this.uuidUser, {Key? key}) : super(key: key);

  // The unique identifier of the user
  final String? uuidUser;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late bool load;
  int state = -1;
  UserModel? user;
  GlobalData? globalData;

  @override
  void initState() {
    super.initState();
    startTime();
  }

  // Initializes the user data
  initUser() async {
    ResponseApi? response = await UserRepository().getUser(context, widget.uuidUser!);
    if (response != null && response.status == 200) {
      UserModel result = UserModel.fromJson(response.body);
      user = result;
    }
  }

  // Sets a timer to delay the verification of pages
  startTime() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, verifyPages);
  }

  // Verifies the authentication status and determines which page to display
  verifyPages() async {
    if (!mounted) return;

    if (widget.uuidUser == null) {
      setState(() {
        state = 1;
      });
    } else {
      await initUser();
      if (user != null) {
        globalData = GlobalData(user!);
        await globalData!.getApiPersonalLibraries(context);
        if (user!.companyUuid != null && user!.companyUuid != "") {
          await globalData!.getApiCompany(context);
          await globalData!.getApiCompanyLibraries(context);
          await globalData!.getApiInformation(context);
        }

        setState(() {
          state = 2;
        });
      }
    }
  }

  // Builds the appropriate page based on the authentication status
  @override
  Widget build(BuildContext context) {
    Widget startPage() {
      switch (state) {
        case 1:
          return const LoginPageWidget();
        case 2:
          return NavBarPage(globalData!);
        default:
          return const SplashScreen();
      }
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: startPage(),
    );
  }
}
