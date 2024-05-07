import 'package:flutter/material.dart';
import 'package:my_tech_lib/services/models/globalData_model.dart';
import 'package:my_tech_lib/services/models/mobileProject_model.dart';
import 'package:my_tech_lib/views/library/create_library_screen.dart';
import 'package:my_tech_lib/views/library/library_screen.dart';
import 'package:my_tech_lib/views/library/modify_library_screen.dart';
import 'package:my_tech_lib/views/project/create_project_screen.dart';
import 'package:my_tech_lib/views/project/modify/mobile_modify_screen.dart';

import '../../main_screen.dart';
import '../../services/models/apiProject_model.dart';
import '../../services/models/company_model.dart';
import '../../services/models/library_model.dart';
import '../../services/models/project_model.dart';
import '../../services/models/user_model.dart';
import '../../services/models/webProject_model.dart';
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
import '../../views/options/settings_screen.dart';
import '../../views/project/api_screen.dart';
import '../../views/project/mobile_screen.dart';
import '../../views/project/modify/api_modify_screen.dart';
import '../../views/project/modify/web_modify_screen.dart';
import '../../views/project/web_screen.dart';
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
  static const String SETTINGS = '/Settings';
  static const String PRIVACY_POLICY = '/PrivacyPolicy';
  static const String NOTIFICATION_SETTINGS = '/Notification';
  static const String ONBOARDING = '/Onboarding';

  static const String COMPANY_EDIT = '/CompanyEdit';
  static const String COMPANY_LIST_POEPLE = '/CompanyListPeople';

  static const String LIBRARY = '/Library';
  static const String CREATE_LIBRARY = '/CreatePublicLibraryWidget';
  static const String MODIFY_LIBRARY = '/ModifyPublicLibraryWidget';

  static const String PROJECT_API = '/ProjectApi';
  static const String PROJECT_WEB = '/ProjectWeb';
  static const String PROJECT_MOBILE = '/ProjectMobile';
  static const String CREATE_PROJECT = '/CreateProject';
  static const String MOBILE_MODIFY_PROJECT = '/MobileModifyProject';
  static const String API_MODIFY_PROJECT = '/ApiModifyProject';
  static const String WEB_MODIFY_PROJECT = '/WebApiModifyProject';

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
        return MaterialPageRoute(
            builder: (_) => NavBarPage(settings.arguments as GlobalData));
      case CHANGE_PASSWORD:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordWidget());
      case EDIT_PROFILE:
        return MaterialPageRoute(
            builder: (_) => EditProfileWidget(settings.arguments as UserModel));
      case SETTINGS:
        return MaterialPageRoute(
            builder: (_) => SettingsPageWidget(settings.arguments as UserModel));
      case PRIVACY_POLICY:
        return MaterialPageRoute(builder: (_) => const PrivacyPolicyWidget());
      case NOTIFICATION_SETTINGS:
        return MaterialPageRoute(builder: (_) => const NotificationsSettingsWidget());
      case ONBOARDING:
        return MaterialPageRoute(builder: (_) => const OnboardingPage());

      case COMPANY_EDIT:
        return MaterialPageRoute(builder: (_) => CompanyEditWidget(settings.arguments as Company));
      case COMPANY_LIST_POEPLE:
        return MaterialPageRoute(
            builder: (_) => CompanyListPeopleWidget(settings.arguments as Company));

      case LIBRARY:
        return MaterialPageRoute(
            builder: (_) => LibraryWidget((settings.arguments! as List<Object>)[0] as UserModel,
                (settings.arguments! as List<Object>)[1] as Library));
      case CREATE_LIBRARY:
        return MaterialPageRoute(
            builder: (_) => CreateLibraryWidget(settings.arguments as UserModel));
      case MODIFY_LIBRARY:
        return MaterialPageRoute(
            builder: (_) => ModifyLibraryWidget(
                (settings.arguments! as List<Object>)[0] as UserModel,
                (settings.arguments! as List<Object>)[1] as Library));

      case PROJECT_MOBILE:
        return MaterialPageRoute(builder: (_) => MobileWidget(settings.arguments as MobileProject));
      case PROJECT_API:
        return MaterialPageRoute(builder: (_) => ApiWidget(settings.arguments as ApiProject));
      case PROJECT_WEB:
        return MaterialPageRoute(builder: (_) => WebWidget(settings.arguments as WebProject));
      case CREATE_PROJECT:
        return MaterialPageRoute(
            builder: (_) => CreateProjectWidget(settings.arguments as Library));
      case MOBILE_MODIFY_PROJECT:
        return MaterialPageRoute(
            builder: (_) => MobileModifyProjectWidget(settings.arguments as MobileProject));
      case API_MODIFY_PROJECT:
        return MaterialPageRoute(
            builder: (_) => ApiModifyProjectWidget(settings.arguments as ApiProject));
      case WEB_MODIFY_PROJECT:
        return MaterialPageRoute(
            builder: (_) => WebModifyProjectWidget(settings.arguments as WebProject));

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
