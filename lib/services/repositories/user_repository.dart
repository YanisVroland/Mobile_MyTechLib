import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:my_tech_lib/services/repositories/utils_repository.dart';

import '../../app/theme/app_const.dart';
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
      return await utilsRepository.requestPost(context, AppConst.signInEndpoint, requestBody);
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
      return await utilsRepository.requestPost(context, AppConst.signUpEndpoint, requestBody);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<ResponseApi?> signOut(BuildContext context) async {
    try {
      var requestBody = {
        'disconnectOther': "true",
      };
      return await utilsRepository.requestPost(context, AppConst.signOutEndpoint, requestBody);
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
