import 'package:flutter/material.dart';

import '../../views/auth/forgot_password_widget.dart';
import '../../views/auth/login_page_widget.dart';
import '../../views/auth/register_account_widget.dart';
import '../../views/navigator/navigator.dart';
import '../../views/options/edit_profile_widget.dart';
import '../../views/options/notifications_settings_widget.dart';
import '../../views/options/privacy_policy_widget.dart';
import '../../views/options/profile_page_widget.dart';
import '../../views/splash_screen.dart';

class AppRouter {
  static const String HOME = '/Home';
  static const String SPLASH = '/Splash';
  static const String LOGIN = '/Login';
  static const String REGISTER = '/Register';
  static const String FORGOT_PASSWORD = '/ForgotPassword';
  static const String CHANGE_PASSWORD = '/ChangePassword';
  static const String EDIT_PROFILE = '/EditProfile';
  static const String PROFILE = '/Profile';
  static const String PRIVACY_POLICY = '/PrivacyPolicy';
  static const String NOTIFICATION_SETTINGS = '/Notification';
  static const String ONBOARDING = '/Onboarding';



  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case LOGIN:
        return MaterialPageRoute(builder: (_) => const LoginPageWidget());
      case REGISTER:
        return MaterialPageRoute(builder: (_) => const RegisterAccountWidget());
      case FORGOT_PASSWORD:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordWidget());
      case SPLASH:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case HOME:
        return MaterialPageRoute(builder: (_) =>  NavBarPage());
      case CHANGE_PASSWORD:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordWidget());
      case EDIT_PROFILE:
        return MaterialPageRoute(builder: (_) => const EditProfileWidget());
      case PROFILE:
        return MaterialPageRoute(builder: (_) => const ProfilePageWidget());
      case PRIVACY_POLICY:
        return MaterialPageRoute(builder: (_) => const PrivacyPolicyWidget());
      case NOTIFICATION_SETTINGS:
        return MaterialPageRoute(builder: (_) => const NotificationsSettingsWidget());
      case ONBOARDING:
        return MaterialPageRoute(builder: (_) => const SplashScreen());


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
