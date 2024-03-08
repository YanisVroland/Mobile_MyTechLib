import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_tech_lib/services/repositories/utils_repository.dart';

import '../../app/theme/app_const.dart';
import '../../app/theme/snackBar_const.dart';
import '../local/pref.dart';
import '../models/responseAPI_model.dart';
import '../models/user_model.dart';

class CompanyRepository {
  UtilsRepository utilsRepository = UtilsRepository();

  Future<ResponseApi?> getCompany(BuildContext context, String companyUuid) async {
    try {
      return utilsRepository.requestGet(context, AppConst.companyGetEndpoint + companyUuid);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }


  Future<ResponseApi?> getUserCompany(BuildContext context, String companyUuid) async {
    try {
      return utilsRepository.requestGet(context, AppConst.companyUsersGetEndpoint + companyUuid);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
