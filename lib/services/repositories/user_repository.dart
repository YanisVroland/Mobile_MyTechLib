import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_tech_lib/services/repositories/utils_repository.dart';

import '../../app/theme/app_const.dart';
import '../../app/theme/snackBar_const.dart';
import '../local/pref.dart';
import '../models/responseAPI_model.dart';
import '../models/user_model.dart';

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
      var requestBody = {
        'email': user.email.trim(),
        'name': user.name.trim(),
        'lastname': user.lastname.trim(),
        'password': user.password.trim(),
      };
      ResponseApi? response =
          await utilsRepository.requestPost(context, AppConst.signUpPostEndpoint, requestBody);

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

  Future<ResponseApi?> getUser(BuildContext context, String uuidUser) async {
    try {
      return utilsRepository.requestGet(context, AppConst.userGetEndpoint + uuidUser);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
