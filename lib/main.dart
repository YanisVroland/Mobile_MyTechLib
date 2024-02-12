import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app/routes/router.dart';
import 'app/theme/app_const.dart';
import 'app/theme/app_theme.dart';
import 'main_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

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
    return  MaterialApp(
          title: AppConst.appName,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRouter.generateRoute,
          theme: ThemeData(
            brightness: Brightness.light,
            scrollbarTheme: ScrollbarThemeData(),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            scrollbarTheme: ScrollbarThemeData(),
          ),
          themeMode: _themeMode,
          home: MainScreen(),
        );
  }
}
