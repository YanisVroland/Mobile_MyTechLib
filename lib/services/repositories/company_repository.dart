import 'dart:developer';
import 'dart:math' as math;

// import 'dart:math' ;
import 'package:dio/dio.dart';
import 'package:path/path.dart' as path;
import 'package:http_parser/http_parser.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_tech_lib/services/repositories/utils_repository.dart';
import 'package:uuid/uuid.dart';

import '../../app/theme/app_const.dart';
import '../models/company_model.dart';
import '../models/responseAPI_model.dart';

class CompanyRepository {
  UtilsRepository utilsRepository = UtilsRepository();

  Future<ResponseApi?> createCompany(BuildContext context, Company company) async {
    try {
      return utilsRepository.requestPost(
          context, AppConst.creatCompanyPostEndpoint, company.toJson());
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<ResponseApi?> joinCompany(BuildContext context, String code) async {
    try {
      return utilsRepository.requestPut(context, AppConst.joinCompanyPutEndpoint + code, {});
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

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

  Future<ResponseApi?> getStatistiqueCompany(BuildContext context, String companyUuid) async {
    try {
      return utilsRepository.requestGet(
          context, AppConst.companyStatistiqueGetEndpoint + companyUuid);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  String generateUniqueString(int length) {
    const characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    var result = '';
    var random = math.Random();
    for (var i = 0; i < length; i++) {
      result += characters[random.nextInt(characters.length)];
    }
    return result;
  }

  Future<ResponseApi?> changeCodeCompany(BuildContext context, String companyUuid) async {
    try {
      String newCode = generateUniqueString(10);
      return utilsRepository.requestPatch(
          context, AppConst.companyUpdateCodePostEndpoint + companyUuid, {'code': newCode});
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<ResponseApi?> leaveCompany(BuildContext context, String userUuid) async {
    try {
      return utilsRepository
          .requestPatch(context, AppConst.companyLeaveCompanyPostEndpoint + userUuid, {});
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<ResponseApi?> updateLogoCompany(
      BuildContext context, Company company, String uploadedFileUrl) async {
    try {
      String extension = path.extension(uploadedFileUrl);

      final url = await MultipartFile.fromFile(
        uploadedFileUrl,
        filename: "logo" + extension,
        contentType: MediaType('image', extension.substring(1)),
      );

      Map<String, Object> bodyJson = {"file": url};

      return utilsRepository.requestImagePost(
          context, AppConst.companyLogoPostEndpoint + company.uuid, bodyJson);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<ResponseApi?> updateCompany(BuildContext context, Company company) async {
    try {
      var requestBody = {
        'name': company.name,
        'description': company.description,
      };
      return utilsRepository.requestPut(
          context, AppConst.companyUpdatePutEndpoint + company.uuid, requestBody);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
