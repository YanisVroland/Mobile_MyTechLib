import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_tech_lib/services/repositories/utils_repository.dart';
import 'package:http_parser/http_parser.dart';

import '../../app/theme/app_const.dart';
import '../../app/theme/snackBar_const.dart';
import '../local/pref.dart';
import '../models/responseAPI_model.dart';
import '../models/user_model.dart';
import 'package:path/path.dart' as path;

class UserRepository {
  UtilsRepository utilsRepository = UtilsRepository();

  Future<ResponseApi?> signIn(BuildContext context, String name, String password) async {
    try {
      var requestBody = {
        'email': name.trim(),
        'password': password.trim(),
      };
      ResponseApi? response =
          await utilsRepository.requestPost(context, AppConst.signInPostEndpoint, requestBody);

      if (response != null && response.status == 200) {
        await LocalPref().saveString("uuid_user", response.body["uuid_user"]);
        await LocalPref().saveString("access_token", response.body["access_token"]);
        await LocalPref().saveString("refresh_token", response.body["refresh_token"]);
      }
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<ResponseApi?> signUp(BuildContext context, UserModel user) async {
    try {

      ResponseApi? response =
          await utilsRepository.requestPost(context, AppConst.signUpPostEndpoint, user.toJson());

      if (response != null && response.status == 201) {
        SnackConst.SnackCustom(AppConst.userCreatedMessage, context,
            duration: 3, color: Colors.green);
        return await signIn(context, user.email, user.password);
      }

      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<ResponseApi?> forgotPassword(BuildContext context, String email) async {
    try {
      var requestBody = {
        'email': email.trim(),
      };
      return utilsRepository.requestPost(context, AppConst.forgotPasswordPostEndpoint, requestBody);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<ResponseApi?> getUser(BuildContext context, String uuidUser) async {
    try {
      return utilsRepository.requestGet(context, AppConst.userGetEndpoint + uuidUser);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<ResponseApi?> updateProfileImageUser(BuildContext context, UserModel user, String uploadedFileUrl) async {
    try {
      String extension = path.extension(uploadedFileUrl);
      final url = await MultipartFile.fromFile(
        uploadedFileUrl,
        filename: "logo"+extension,
        contentType: MediaType('image', extension.substring(1)),
      );

      Map<String, Object> bodyJson = {"file": url};


      return utilsRepository.requestImagePost(context, AppConst.userImageProfilePatchEndpoint + user.uuid, bodyJson);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<ResponseApi?> updateUser(BuildContext context, UserModel user) async {
    try {
      var requestBody = {
        'name': user.name.trim(),
        'lastName': user.lastname.trim(),
      };
      return utilsRepository.requestPut(context, AppConst.userUpdatePutEndpoint + user.uuid, requestBody);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
