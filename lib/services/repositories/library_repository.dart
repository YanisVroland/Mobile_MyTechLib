import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_tech_lib/services/repositories/utils_repository.dart';

import '../../app/theme/app_const.dart';
import '../../app/theme/snackBar_const.dart';
import '../local/pref.dart';
import '../models/responseAPI_model.dart';
import '../models/user_model.dart';

class LibraryRepository {
  UtilsRepository utilsRepository = UtilsRepository();

  Future<ResponseApi?> getPersonalLibrary(BuildContext context) async {
    String uuidUser = await LocalPref().getString("uuid_user");
    try {
      return utilsRepository.requestGet(context, AppConst.libraryUserGetEndpoint + uuidUser);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<ResponseApi?> getCompanyLibrary(BuildContext context, String companyUuid) async {
    try {
      return utilsRepository.requestGet(context, AppConst.libraryCompanyGetEndpoint + companyUuid);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
