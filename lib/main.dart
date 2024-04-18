import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_tech_lib/views/auth/login_page_screen.dart';

import 'app/routes/router.dart';
import 'app/theme/app_const.dart';
import 'app/theme/app_theme.dart';
import 'main_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await AppTheme.initialize();
  runApp(MyApp());
}


class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = AppTheme.themeMode;

  void setThemeMode(ThemeMode mode) => setState(() {
    _themeMode = mode;
    AppTheme.saveThemeMode(mode);
  });


  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
        builder: () => MaterialApp(
          title: AppConst.appName,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRouter.generateRoute,
          theme: ThemeData(
            brightness: Brightness.light,
            scrollbarTheme: const ScrollbarThemeData(),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            scrollbarTheme: const ScrollbarThemeData(),
            useMaterial3: true,
          ),
          themeMode: _themeMode,
          home: LoginPageWidget(),
        ));
  }
}
