import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_tech_lib/services/models/information_model.dart';
import 'package:my_tech_lib/services/repositories/utils_repository.dart';

import '../../app/theme/app_const.dart';
import '../models/responseAPI_model.dart';
import '../models/information_model.dart';

class InformationRepository {
  UtilsRepository utilsRepository = UtilsRepository();

  Future<ResponseApi?> IetinformationByCompany(BuildContext context, String uuidCompany) async {
    try {
      return utilsRepository.requestGet(context, AppConst.informationByCompanyGetEndpoint + uuidCompany);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<ResponseApi?> Ireateinformation(BuildContext context, Information information) async {
    try {
      return utilsRepository.requestPost(context, AppConst.informationCreateEndpoint, information.toJson());
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
