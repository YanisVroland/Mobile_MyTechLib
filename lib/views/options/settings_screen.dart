import 'dart:math';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_tech_lib/app/theme/color_const.dart';
import 'package:my_tech_lib/services/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/routes/router.dart';
import '../../app/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../../app/widgets/button_custom.dart';
import '../../app/widgets/icon_custom.dart';
import '../../main.dart';

class SettingsPageWidget extends StatefulWidget {
  const SettingsPageWidget(this.user, {Key? key}) : super(key: key);
  final UserModel user;

  @override
  _ProfilePageWidgetState createState() => _ProfilePageWidgetState();
}

class _ProfilePageWidgetState extends State<SettingsPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setDarkModeSetting(BuildContext context, ThemeMode mode) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Changer de mode'),
              content: const Text('Vous allez être déconnecté. Voulez-vous continuer ?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('NON'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    AppTheme.saveThemeMode(mode);
                    SharedPreferences.getInstance().then((prefs) {
                      if (prefs != null) {
                        prefs.setBool(kThemeModeKey, mode == ThemeMode.dark);
                        AppTheme.saveThemeMode(mode);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => MyApp()),
                        );
                      }
                    });
                  },
                  child: const Text('OUI'),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppTheme.of(context).background,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width * 1.0,
              height: 200.0,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    blurRadius: 2.0,
                    color: Color(0x4B1A1F24),
                    offset: Offset(0.0, 2.0),
                  )
                ],
                gradient: const LinearGradient(
                  colors: [Color(0xFF00968A), Color(0xFFF2A384)],
                  stops: [0.0, 1.0],
                  begin: AlignmentDirectional(0.94, -1.0),
                  end: AlignmentDirectional(-0.94, 1.0),
                ),
                borderRadius: BorderRadius.circular(0.0),
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 0.0, 0.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 50.0, 0.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: AppTheme.of(context).primary,
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(2.0, 2.0, 2.0, 2.0),
                              child: Container(
                                  width: 60.0,
                                  height: 60.0,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: widget.user.profile_url.isEmpty
                                      ? Image.asset(
                                          'assets/images/tlchargement.png',
                                          fit: BoxFit.cover,
                                        )
                                      : Image.network(
                                          widget.user.profile_url,
                                          fit: BoxFit.cover,
                                        )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 16.0, 0.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                                  child: Container(
                                    width: 44.0,
                                    height: 44.0,
                                    decoration: BoxDecoration(
                                      color: ColorConst.delete,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: IconCustom(
                                      icon: const Icon(
                                        Icons.login_rounded,
                                        color: Colors.white,
                                        size: 24.0,
                                      ),
                                      onPressed: () async {
                                        Navigator.pushNamedAndRemoveUntil(
                                            context, '/Login', (Route<dynamic> route) => false);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(widget.user.name + " " + widget.user.lastname,
                              style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 8.0, 0.0, 0.0),
                          child: Text(
                            widget.user.email,
                            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
              child: const Text("Mon compte",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            ),
            InkWell(
              onTap: () async {
                Navigator.pushNamed(context, AppRouter.EDIT_PROFILE, arguments: widget.user);
              },
              child: Container(
                width: MediaQuery.sizeOf(context).width * 0.9,
                height: 60.0,
                decoration: BoxDecoration(
                  color: AppTheme.of(context).background,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    width: 1.0,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 4.0, 0.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Editer le profil",
                      ),
                      IconCustom(
                        borderColor: Colors.transparent,
                        borderRadius: 30.0,
                        buttonSize: 46.0,
                        icon: const Icon(
                          Icons.chevron_right_rounded,
                          color: Color(0xFF95A1AC),
                          size: 20.0,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, AppRouter.EDIT_PROFILE, arguments: widget.user);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
              child: InkWell(
                  onTap: () async {
                    Navigator.pushNamed(context, AppRouter.CHANGE_PASSWORD);
                  },
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: AppTheme.of(context).background,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(
                        width: 1.0,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 4.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Changer le mot de passe",
                          ),
                          IconCustom(
                            borderColor: Colors.transparent,
                            borderRadius: 30.0,
                            buttonSize: 46.0,
                            icon: const Icon(
                              Icons.chevron_right_rounded,
                              color: Color(0xFF95A1AC),
                              size: 20.0,
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, AppRouter.CHANGE_PASSWORD);
                            },
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
              child: InkWell(
                onTap: () async {
                  Navigator.pushNamed(context, AppRouter.NOTIFICATION_SETTINGS);
                },
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: AppTheme.of(context).background,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      width: 1.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 4.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Paramètres de notification",
                        ),
                        IconCustom(
                          borderColor: Colors.transparent,
                          borderRadius: 30.0,
                          buttonSize: 46.0,
                          icon: const Icon(
                            Icons.chevron_right_rounded,
                            color: Color(0xFF95A1AC),
                            size: 20.0,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, AppRouter.NOTIFICATION_SETTINGS);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
              child: InkWell(
                onTap: () async {
                  Navigator.pushNamed(context, AppRouter.ONBOARDING);
                },
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: AppTheme.of(context).background,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      width: 1.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 4.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Tutoriel",
                        ),
                        IconCustom(
                          borderColor: Colors.transparent,
                          borderRadius: 30.0,
                          buttonSize: 46.0,
                          icon: const Icon(
                            Icons.chevron_right_rounded,
                            color: Color(0xFF95A1AC),
                            size: 20.0,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, AppRouter.ONBOARDING);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 12.0, 0.0, 0.0),
              child: InkWell(
                onTap: () async {
                  Navigator.pushNamed(context, AppRouter.PRIVACY_POLICY);
                },
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.9,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: AppTheme.of(context).background,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      width: 1.0,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 4.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Politique de confidentialité",
                        ),
                        IconCustom(
                          borderColor: Colors.transparent,
                          borderRadius: 30.0,
                          buttonSize: 46.0,
                          icon: const Icon(
                            Icons.chevron_right_rounded,
                            color: Color(0xFF95A1AC),
                            size: 20.0,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, AppRouter.PRIVACY_POLICY);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(20.0, 30.0, 20.0, 16.0),
              child: Container(
                height: 50.0,
                decoration: BoxDecoration(
                  color: AppTheme.of(context).background,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    width: 1.0,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(4.0, 4.0, 4.0, 4.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            setDarkModeSetting(context, ThemeMode.light);
                          },
                          child: Container(
                            height: 100.0,
                            decoration: Theme.of(context).brightness != Brightness.dark
                                ? BoxDecoration(
                                    color: Theme.of(context).brightness == Brightness.light
                                        ? Colors.white
                                        : const Color(0xFFF1F4F8),
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                      color: Theme.of(context).brightness == Brightness.light
                                          ? const Color(0xFFE0E3E7)
                                          : const Color(0xFFF1F4F8),
                                      width: 1.0,
                                    ),
                                  )
                                : null,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.wb_sunny_rounded,
                                  color: Theme.of(context).brightness == Brightness.light
                                      ? const Color(0xFF14181B)
                                      : const Color(0xFF57636C),
                                  size: 16.0,
                                ),
                                const Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 0.0, 0.0),
                                  child: Text(
                                    "Mode lumière",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            setDarkModeSetting(context, ThemeMode.dark);
                          },
                          child: Container(
                            height: 100.0,
                            decoration: Theme.of(context).brightness == Brightness.dark
                                ? BoxDecoration(
                              color:  Theme.of(context).brightness == Brightness.dark
                                ? const Color(0xFF14181B)
                                : const Color(0xFF57636C),
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                width: 1.0,
                              ),
                            )
                                : null,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.nightlight_round,
                                  color: Theme.of(context).brightness == Brightness.dark
                                      ? const Color(0xFF57636C)
                                      : const Color(0xFF14181B),
                                  size: 16.0,
                                ),
                                const Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(4.0, 0.0, 0.0, 0.0),
                                  child: Text("Mode sombre"),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
              child: CustomButton(
                text: "Retour",
                onTap: () async {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
