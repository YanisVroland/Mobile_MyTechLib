import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;
import 'package:http_parser/http_parser.dart';

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
      ResponseApi? responseApi = await utilsRepository.requestPost(
          context, AppConst.projectCreateEndpoint, project.toJson());
      if (project.core_company != null && responseApi != null && responseApi.status == 201) {
        informationRepository.createInformation(
            context,
            Information(
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

  Future<ResponseApi?> updateLogoProject(
      BuildContext context, String projectUuid, String uploadedFileUrl) async {
    try {
      String extension = path.extension(uploadedFileUrl);

      final url = await MultipartFile.fromFile(
        uploadedFileUrl,
        filename: "logo" + extension,
        contentType: MediaType('image', extension.substring(1)),
      );

      Map<String, Object> bodyJson = {"file": url};

      return utilsRepository.requestImagePost(
          context, AppConst.projectLogoPostEndpoint + projectUuid, bodyJson);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<ResponseApi?> uploadIllustrations(
      BuildContext context, String projectUuid, List<String> illustrations) async {
    try {
      List<MultipartFile> files = [];
      for (int i = 0, len = illustrations.length; i < len; i++) {
        if (illustrations[i].isNotEmpty) {
          String extension = path.extension(illustrations[i]);

          final url = await MultipartFile.fromFile(
            illustrations[i],
            filename: "illustration_$i" + extension,
            contentType: MediaType('image', extension.substring(1)),
          );

          files.add(url);
        }
      }
      if (files.isEmpty) return null;
      Map<String, Object> bodyJson = {"files": files};

      return utilsRepository.requestImagePost(
          context, AppConst.projectIllustrationsPostEndpoint + projectUuid, bodyJson);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<ResponseApi?> updateApkProject(
      BuildContext context, String projectUuid, String uploadedFileUrl) async {
    try {
      String extension = path.extension(uploadedFileUrl);

      final url = await MultipartFile.fromFile(
        uploadedFileUrl,
        filename: "apk" + extension,
        contentType: MediaType('application', 'vnd.android.package-archive'),
      );

      Map<String, Object> bodyJson = {"file": url};

      return utilsRepository.requestImagePost(
          context, AppConst.projectApkPostEndpoint + projectUuid, bodyJson);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<ResponseApi?> deleteProject(BuildContext context, Project project) async {
    try {
      return utilsRepository.requestDelete(context, AppConst.projectDeleteEndpoint + project.uuid);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
