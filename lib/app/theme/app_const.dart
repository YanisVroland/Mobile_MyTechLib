
class AppConst {
  static const String appName = 'MyTechLib';
  static const String appVersion = '1.0.0';

  static const String baseUrl = 'http://10.238.16.23:3003';
  static const String anonToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFyeHVwZm9laXl5dm93Y2JreXp3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDcyMjEwMDYsImV4cCI6MjAyMjc5NzAwNn0.lDcM6CgAk3dAKhtke5q66beviyptGvhLDNemvhhJlTE';

  // Endpoints
  static String signInEndpoint = '/user/auth';
  static String signUpEndpoint = '/user/registration';
  static String signOutEndpoint = '/user/signOut';

  // Messages
  static String errorApiMessage = 'Erreur de fonctionnement, veuillez contacter le support.';
  static String errorSearchMessage = 'Element recherché introuvable';
  static String missingDataMessage = 'Aucune information disponible';

}
