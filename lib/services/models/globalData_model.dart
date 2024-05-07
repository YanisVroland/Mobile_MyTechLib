import 'package:flutter/cupertino.dart';
import 'package:my_tech_lib/services/models/responseAPI_model.dart';
import 'package:my_tech_lib/services/models/user_model.dart';

import '../repositories/company_repository.dart';
import '../repositories/information_repository.dart';
import '../repositories/library_repository.dart';
import 'company_model.dart';
import 'information_model.dart';
import 'library_model.dart';

class GlobalData {
  late UserModel user;
  late Company? company;
  late List<Library> listPersonalLibrairies;
  late List<Library> listCompanyLibrairies;
  late List<Information> listInformation;

  GlobalData(this.user) {
    listPersonalLibrairies = [];
    listCompanyLibrairies = [];
    listInformation = [];
  }

  getApiPersonalLibraries(BuildContext context) async {
    ResponseApi? response = await LibraryRepository().getPersonalLibrary(context);
    if (response != null && response.status == 200) {
      List<dynamic> result = await response.body.map((doc) => Library.fromJson(doc)).toList();
      listPersonalLibrairies = result.cast<Library>();
      return;
    }
    listPersonalLibrairies = [];
  }

  getApiCompanyLibraries(BuildContext context) async {
    if (user.companyUuid.isNotEmpty) {
      ResponseApi? response =
          await LibraryRepository().getCompanyLibrary(context, user.companyUuid);
      if (response != null && response.status == 200) {
        List<dynamic> result = await response.body.map((doc) => Library.fromJson(doc)).toList();
        listCompanyLibrairies = result.cast<Library>();
        return;
      }
    }
    listCompanyLibrairies = [];
  }

  getApiInformation(BuildContext context) async {
    ResponseApi? response =
        await InformationRepository().getInformationByCompany(context, user.companyUuid);
    if (response != null && response.status == 200) {
      List<dynamic> result = await response.body.map((doc) => Information.fromJson(doc)).toList();
      listInformation = result.cast<Information>();
      return;
    }
    listInformation = [];
  }

  getApiCompany(
    BuildContext context,
  ) async {
    ResponseApi? response = await CompanyRepository().getCompany(context, user!.companyUuid);
    if (response != null && response.status == 200) {
      Company result = Company.fromJson(response.body);
      company = result;
      return;
    }
  }
}
