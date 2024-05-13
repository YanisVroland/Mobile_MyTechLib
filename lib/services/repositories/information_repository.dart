/*
  This file contains a repository class for managing information-related operations.
*/

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../app/theme/app_const.dart';
import '../models/responseAPI_model.dart';
import '../models/information_model.dart';
import '../repositories/utils_repository.dart';

class InformationRepository {
  UtilsRepository utilsRepository = UtilsRepository();

  // Method to get information by company UUID
  Future<ResponseApi?> getInformationByCompany(
      BuildContext context, String uuidCompany) async {
    try {
      return utilsRepository.requestGet(
          context, AppConst.informationByCompanyGetEndpoint + uuidCompany);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  // Method to create information
  Future<ResponseApi?> createInformation(
      BuildContext context, Information information) async {
    try {
      return utilsRepository.requestPost(
          context, AppConst.informationCreateEndpoint, information.toJson());
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
