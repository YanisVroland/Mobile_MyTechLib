
class AppConst {
  static const String appName = 'MyTechLib';
  static const String appVersion = '1.0.0';

  static const String baseUrl = 'http://localhost:3003/';

  // Endpoints
  static String signInEndpoint = '/user/auth';
  static String signUpEndpoint = '/user/registration';
  static String signOutEndpoint = '/user/signOut';

  // Messages
  static String errorApiMessage = 'Erreur de fonctionnement, veuillez contacter le support.';
  static String errorSearchMessage = 'Element recherché introuvable';
  static String missingDataMessage = 'Aucune information disponible';

}
