import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_tech_lib/services/repositories/utils_repository.dart';
import 'package:uuid/uuid.dart';

import '../../app/theme/app_const.dart';
import '../models/responseAPI_model.dart';

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

  Future<ResponseApi?> changeCodeCompany(BuildContext context, String companyUuid) async {
    try {
      String newCode = Uuid().v4();
      return utilsRepository.requestPatch(context, AppConst.companyUpdateCodePostEndpoint + companyUuid,{'code': newCode});
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<ResponseApi?> leaveCompany(BuildContext context, String userUuid) async {
    try {
      return utilsRepository.requestPatch(context, AppConst.companyLeaveCompanyPostEndpoint + userUuid,{});
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
