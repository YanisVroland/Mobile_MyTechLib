/*
  This file contains a custom AppBar widget used throughout the application.
*/

import 'package:flutter/material.dart';
import 'package:my_tech_lib/services/models/user_model.dart';

import '../routes/router.dart';
import '../theme/app_const.dart';
import '../theme/app_theme.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar(
      this.user, {
        Key? key,
      }) : super(key: key);
  UserModel user;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppTheme.of(context).secondaryBackground,
      automaticallyImplyLeading: false,
      title: const Text(
        AppConst.appName,
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
      leading: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(15.0, 0.0, .0, 0.0),
        child: Image.asset(
          'assets/images/logo.png',
          width: 40,
          height: 40,
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 15.0, 0.0),
          child: InkWell(
            onTap: () async {
              Navigator.pushNamed(context, AppRouter.SETTINGS, arguments: user);
            },
            child: const Icon(
              Icons.settings,
              size: 26.0,
            ),
          ),
        ),
      ],
      centerTitle: true,
      elevation: 5.0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
