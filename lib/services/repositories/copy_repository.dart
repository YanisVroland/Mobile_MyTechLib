/*
  This file contains a repository class for managing copy-related operations.
*/

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../app/theme/app_const.dart';
import '../models/responseAPI_model.dart';
import '../repositories/utils_repository.dart';

class CopyRepository {
  UtilsRepository utilsRepository = UtilsRepository();

  // Method to create a copy of a library by UUID
  Future<ResponseApi?> createCopyLibrary(
      BuildContext context, String uuidLibrary) async {
    try {
      return utilsRepository.requestPost(
          context, AppConst.copyLibraryCreateEndpoint + uuidLibrary, {});
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  // Method to use a copy of a library by code
  Future<ResponseApi?> useCopyLibrary(
      BuildContext context, String codeCopy) async {
    try {
      return utilsRepository.requestPost(
          context, AppConst.useCopyLibraryPostEndpoint + codeCopy, {});
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
