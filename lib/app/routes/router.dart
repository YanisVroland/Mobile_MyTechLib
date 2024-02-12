import 'package:flutter/material.dart';

import '../../views/auth/forgot_password_widget.dart';
import '../../views/auth/login_page_widget.dart';
import '../../views/auth/register_account_widget.dart';
import '../../views/splash_screen.dart';

class AppRouter {
  static const String HOME = '/Home';
  static const String SPLASH = '/Splash';
  static const String LOGIN = '/Login';
  static const String REGISTER = '/Register';
  static const String FORGOTPASSWORD = '/ForgotPassword';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LOGIN:
        return MaterialPageRoute(builder: (_) => const LoginPageWidget());
      case REGISTER:
        return MaterialPageRoute(builder: (_) => const RegisterAccountWidget());
      case FORGOTPASSWORD:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordWidget());
      case SPLASH:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      // case HOME:
      //   return MaterialPageRoute(builder: (_) =>  NavBarPage());

      // case ACTIVITY:
      //   return MaterialPageRoute(
      //       builder: (_) => ActivitiesScreen(
      //           (settings.arguments! as List<Object>)[0] as ProductionOrder,
      //           (settings.arguments! as List<Object>)[1] as Operator));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
