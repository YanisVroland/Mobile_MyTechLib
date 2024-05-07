
class AppConst {
  static const String appName = 'MyTechLib';
  static const String appVersion = '1.0.0';

  static const String baseUrl = 'http://192.168.1.177:3000';
  // static const String baseUrl = 'https://api-my-tech-lib.vercel.app';
  static const String anonToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFyeHVwZm9laXl5dm93Y2JreXp3Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDcyMjEwMDYsImV4cCI6MjAyMjc5NzAwNn0.lDcM6CgAk3dAKhtke5q66beviyptGvhLDNemvhhJlTE';

  // Endpoints
  // -> USER
  static String signInPostEndpoint = '/user/auth';
  static String signUpPostEndpoint = '/user/registration';
  static String userGetEndpoint = '/user/';
  static String setCompanyAdminPutEndpoint = '/user/setCompanyAdmin/';
  static String forgotPasswordPostEndpoint = '/user/forgot-password/';
  static String userImageProfilePatchEndpoint = '/user/uploadImageProfile/';
  static String userUpdatePutEndpoint = '/user/';
  static String companyLeaveCompanyPostEndpoint = '/user/leaveCompany/';

  // -> Library
  static String libraryUserGetEndpoint = '/library/byUser/';
  static String libraryCompanyGetEndpoint = '/library/byCompany/';
  static String libraryLogoPostEndpoint = '/library/uploadLogo/';
  static String libraryBannerPostEndpoint = '/library/uploadBanner/';
  static String libraryCountProjectUpdatePatchEndpoint = '/library/countProject/';
  static String libraryUpdatePatchEndpoint = '/library/';
  static String libraryCreateEndpoint = '/library/';
  static String libraryDeleteEndpoint = '/library/';

  // -> Project
  static String projectGetEndpoint = '/project/byLibrary/';
  static String projectUpdateEndpoint = '/project/';
  static String projectCreateEndpoint = '/project/';
  static String projectDeleteEndpoint = '/project/';
  static String projectLogoPostEndpoint = '/project/uploadLogo/';
  static String projectIllustrationsPostEndpoint = '/project/uploadIllustrations/';
  static String projectOneIllustrationPostEndpoint = '/project/uploadIllustration/';
  static String projectApkPostEndpoint = '/project/uploadApk/';



  // -> Company
  static String companyGetEndpoint = '/company/';
  static String creatCompanyPostEndpoint = '/company/';
  static String joinCompanyPutEndpoint = '/company/joinCompany/';
  static String companyUsersGetEndpoint = '/company/user/';
  static String companyStatistiqueGetEndpoint = '/company/statistique/';
  static String companyUpdateCodePostEndpoint = '/company/updateCode/';
  static String companyUpdatePutEndpoint = '/company/';
  static String companyLogoPostEndpoint = '/company/uploadLogo/';


  // -> Information
  static String informationByCompanyGetEndpoint = '/information/byCompany/';
  static String informationCreateEndpoint = '/information/';

  // -> Copy
  static String copyLibraryCreateEndpoint = '/copy/createCopyLibrary/';
  static String   useCopyLibraryPostEndpoint = '/copy/useCopyLibrary/';

  // Messages
  static String errorApiMessage = 'Erreur de fonctionnement, veuillez contacter le support.';
  static String errorSearchMessage = 'Element recherché introuvable';
  static String missingDataMessage = 'Aucune information disponible';
  static String userCreatedMessage = 'Compte utilisateur créé avec succès';

}
