
class AppConst {
  static const String appName = 'MyTechLib';
  static const String appVersion = '1.0.0';

  static const String baseUrl = 'http://10.238.16.27:3000';
  static const String anonToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFyeHVwZm9laXl5dm93Y2JreXp3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDcyMjEwMDYsImV4cCI6MjAyMjc5NzAwNn0.lDcM6CgAk3dAKhtke5q66beviyptGvhLDNemvhhJlTE';

  // Endpoints
  // -> USER
  static String signInPostEndpoint = '/user/auth';
  static String signUpPostEndpoint = '/user/registration';
  static String userGetEndpoint = '/user/';

  // -> Library
  static String libraryUserGetEndpoint = '/library/byUser/';
  static String libraryCompanyGetEndpoint = '/library/byCompany/';
  static String libraryCreateEndpoint = '/library/';
  static String libraryDeleteEndpoint = '/library/';

  // -> Project
  static String projectGetEndpoint = '/project/byLibrary/';
  static String projectCreateEndpoint = '/project/';

  // -> Company
  static String companyGetEndpoint = '/company/';
  static String companyUsersGetEndpoint = '/company/user/';

  // -> Information
  static String informationByCompanyGetEndpoint = '/information/byCompany/';
  static String informationCreateEndpoint = '/information/';



  // Messages
  static String errorApiMessage = 'Erreur de fonctionnement, veuillez contacter le support.';
  static String errorSearchMessage = 'Element recherché introuvable';
  static String missingDataMessage = 'Aucune information disponible';
  static String userCreatedMessage = 'Compte utilisateur créé avec succès';

}
