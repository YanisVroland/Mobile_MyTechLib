import 'package:flutter/material.dart';
import 'package:my_tech_lib/views/library/create_library_screen.dart';
import 'package:my_tech_lib/views/library/library_screen.dart';
import 'package:my_tech_lib/views/project/create_project_screen.dart';
import 'package:my_tech_lib/views/project/project_screen.dart';

import '../../main_screen.dart';
import '../../services/models/company_model.dart';
import '../../services/models/library_model.dart';
import '../../services/models/project_model.dart';
import '../../services/models/user_model.dart';
import '../../views/auth/forgot_password_screen.dart';
import '../../views/auth/login_page_screen.dart';
import '../../views/auth/onboarding_screen.dart';
import '../../views/auth/register_account_screen.dart';
import '../../views/company/company_edit_screen.dart';
import '../../views/company/company_list_people_screen.dart';
import '../../views/navigator/navigator.dart';
import '../../views/options/edit_profile_widget.dart';
import '../../views/options/notifications_settings_widget.dart';
import '../../views/options/privacy_policy_widget.dart';
import '../../views/options/profile_page_widget.dart';
import '../../views/splash_screen.dart';

class AppRouter {
  static const String MAIN = '/Main';
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

  static const String COMPANY_EDIT = '/CompanyEdit';
  static const String COMPANY_LIST_POEPLE = '/CompanyListPeople';

  static const String LIBRARY = '/Library';
  static const String CREATE_LIBRARY = '/CreatePublicLibraryWidget';

  static const String PROJECT = '/Project';
  static const String CREATE_PROJECT = '/CreateProject';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MAIN:
        return MaterialPageRoute(builder: (_) => MainScreen(settings.arguments as String?));
      case LOGIN:
        return MaterialPageRoute(builder: (_) => const LoginPageWidget());
      case REGISTER:
        return MaterialPageRoute(builder: (_) => const RegisterAccountWidget());
      case FORGOT_PASSWORD:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordWidget());
      case SPLASH:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case HOME:
        return MaterialPageRoute(builder: (_) => NavBarPage(
                    (settings.arguments! as List<Object>)[0] as UserModel,
                    (settings.arguments! as List<Object>)[1] as Company));
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
        return MaterialPageRoute(builder: (_) => const OnboardingPage());

      case COMPANY_EDIT:
        return MaterialPageRoute(builder: (_) => const CompanyEditWidget());
      case COMPANY_LIST_POEPLE:
        return MaterialPageRoute(
            builder: (_) => CompanyListPeopleWidget(settings.arguments as List<UserModel>));

      case LIBRARY:
        return MaterialPageRoute(builder: (_) =>  LibraryWidget(settings.arguments as Library));
      case CREATE_LIBRARY:
        return MaterialPageRoute(builder: (_) =>  CreateLibraryWidget(settings.arguments as UserModel));

      case PROJECT:
        return MaterialPageRoute(builder: (_) => ProjectWidget(settings.arguments as Project));
      case CREATE_PROJECT:
        return MaterialPageRoute(builder: (_) =>  CreateProjectWidget(settings.arguments as Library));

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
