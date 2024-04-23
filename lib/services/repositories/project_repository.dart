import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_tech_lib/services/models/library_model.dart';
import 'package:my_tech_lib/services/models/project_model.dart';
import 'package:my_tech_lib/services/repositories/utils_repository.dart';

import '../../app/theme/app_const.dart';
import '../models/information_model.dart';
import '../models/responseAPI_model.dart';
import 'information_repository.dart';

class ProjectRepository {
  UtilsRepository utilsRepository = UtilsRepository();
  InformationRepository informationRepository = InformationRepository();

  Future<ResponseApi?> getProjectByLibrary(BuildContext context, String uuidLibrary) async {
    try {
      return utilsRepository.requestGet(context, AppConst.projectGetEndpoint + uuidLibrary);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<ResponseApi?> createProject(BuildContext context, Project project, Library library) async {
    try {
      ResponseApi? responseApi =await utilsRepository.requestPost(context, AppConst.projectCreateEndpoint, project.toJson());
      if (project.core_company != null && responseApi != null && responseApi.status == 201) {
        informationRepository.createInformation(context, Information(
          core_company: project.core_company,
          core_library: library,
          core_project: project,
          type: "NEW",
        ));
      }
      return responseApi;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }


  Future<ResponseApi?> updateLogoProject(BuildContext context, String projectUuid, String uploadedFileUrl) async {
    try {
      String extension = path.extension(uploadedFileUrl);

      final url = await MultipartFile.fromFile(
        uploadedFileUrl,
        filename: "logo"+extension,
      );

      Map<String, Object> bodyJson = {"file": url};

      return utilsRepository.requestImagePost(context, AppConst.projectLogoPostEndpoint + projectUuid, bodyJson);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
