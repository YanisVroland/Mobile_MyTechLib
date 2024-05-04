import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_tech_lib/services/models/information_model.dart';
import 'package:my_tech_lib/services/repositories/utils_repository.dart';

import '../../app/theme/app_const.dart';
import '../models/responseAPI_model.dart';

class CopyRepository {
  UtilsRepository utilsRepository = UtilsRepository();

  Future<ResponseApi?> createCopyLibrary(BuildContext context, String uuidLibrary) async {
    try {
      return utilsRepository.requestPost(context, AppConst.copyLibraryCreateEndpoint + uuidLibrary, {});
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
