import 'dart:developer';
import 'package:path/path.dart' as path;
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_tech_lib/services/models/information_model.dart';
import 'package:my_tech_lib/services/models/library_model.dart';
import 'package:my_tech_lib/services/repositories/information_repository.dart';
import 'package:my_tech_lib/services/repositories/utils_repository.dart';

import '../../app/theme/app_const.dart';
import '../local/pref.dart';
import '../models/responseAPI_model.dart';

class LibraryRepository {
  UtilsRepository utilsRepository = UtilsRepository();
  InformationRepository informationRepository = InformationRepository();

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

  Future<ResponseApi?> createLibrary(BuildContext context, Library library) async {
    try {
      ResponseApi? responseApi = await utilsRepository.requestPost(
          context, AppConst.libraryCreateEndpoint, library.toJson());

      if (library.core_company != null && responseApi != null && responseApi.status == 201) {
        informationRepository.createInformation(context, Information(
          core_company: library.core_company,
          core_library: library,
          type: "NEW",
        ));

        if(library.logoUrl != null){
          await uploadLogo(context, responseApi.body['uuid'], library.logoUrl);
        }
        if(library.bannerUrl != null){
          await uploadBanner(context, responseApi.body['uuid'], library.bannerUrl);
        }


      }

      return responseApi;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<ResponseApi?> deleteLibrary(BuildContext context, String uuid) async {
    try {
      return utilsRepository.requestDelete(context, AppConst.libraryDeleteEndpoint + uuid);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }


  Future<ResponseApi?> uploadLogo(
      BuildContext context, String libraryUuid, String uploadedFileUrl) async {
    try {
      String extension = path.extension(uploadedFileUrl);

      final url = await MultipartFile.fromFile(
        uploadedFileUrl,
        filename: "logo" + extension,
      );

      Map<String, Object> bodyJson = {"file": url};

      return utilsRepository.requestImagePost(
          context, AppConst.libraryLogoPostEndpoint + libraryUuid, bodyJson);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<ResponseApi?> uploadBanner(
      BuildContext context, String libraryUuid, String uploadedFileUrl) async {
    try {
      String extension = path.extension(uploadedFileUrl);

      final url = await MultipartFile.fromFile(
        uploadedFileUrl,
        filename: "banner" + extension,
      );

      Map<String, Object> bodyJson = {"file": url};

      return utilsRepository.requestImagePost(
          context, AppConst.libraryBannerPostEndpoint + libraryUuid, bodyJson);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
