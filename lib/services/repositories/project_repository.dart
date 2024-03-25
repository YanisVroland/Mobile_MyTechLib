import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_tech_lib/services/models/library_model.dart';
import 'package:my_tech_lib/services/models/project_model.dart';
import 'package:my_tech_lib/services/repositories/utils_repository.dart';

import '../../app/theme/app_const.dart';
import '../../app/theme/snackBar_const.dart';
import '../local/pref.dart';
import '../models/responseAPI_model.dart';
import '../models/user_model.dart';

class ProjectRepository {
  UtilsRepository utilsRepository = UtilsRepository();

  Future<ResponseApi?> getProjectByLibrary(BuildContext context, String uuidLibrary) async {
    try {
      return utilsRepository.requestGet(context, AppConst.projectGetEndpoint + uuidLibrary);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<ResponseApi?> createProject(BuildContext context, Project project) async {
    try {
      return utilsRepository.requestPost(context, AppConst.projectCreateEndpoint, project.toJson());
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
