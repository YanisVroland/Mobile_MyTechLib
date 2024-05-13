/*
  This file contains a repository class for managing utility functions related to API requests
*/

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../app/theme/app_const.dart';
import 'package:http/http.dart' as http;

import '../../app/theme/snackBar_const.dart';
import '../local/pref.dart';
import '../models/responseAPI_model.dart';

class UtilsRepository {

  // Make a POST request
  Future<ResponseApi?> requestPost(
      BuildContext context, String endpoint, Map<String, dynamic> bodyJson) async {
    try {
      String accessToken = await LocalPref().getString("access_token");
      final response = await http.post(
        Uri.parse(AppConst.baseUrl + endpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + (accessToken.isNotEmpty ? accessToken : AppConst.anonToken),
        },
        body: jsonEncode(bodyJson),
      );

      return await verificationResponse(context, response, endpoint);
    } catch (e) {
      throw Exception(e);
    }
  }

  // Make a PATCH request
  Future<ResponseApi?> requestPatch(
      BuildContext context, String endpoint, Map<String, dynamic> bodyJson) async {
    try {
      String accessToken = await LocalPref().getString("access_token");
      final response = await http.patch(
        Uri.parse(AppConst.baseUrl + endpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + (accessToken.isNotEmpty ? accessToken : AppConst.anonToken),
        },
        body: jsonEncode(bodyJson),
      );

      return await verificationResponse(context, response, endpoint);
    } catch (e) {
      throw Exception(e);
    }
  }

  // Make a GET request
  Future<ResponseApi?> requestGet(BuildContext context, String endpoint) async {
    try {
      String accessToken = await LocalPref().getString("access_token");

      var response = await http.get(
        Uri.parse(AppConst.baseUrl + endpoint),
        headers: <String, String>{'Authorization': 'Bearer ' + accessToken},
      );
      return await verificationResponse(context, response, endpoint);
    } catch (e) {
      throw Exception(e);
    }
  }

  // Make a PUT request
  Future<ResponseApi?> requestPut(
      BuildContext context, String endpoint, Map<String, dynamic> bodyJson) async {
    try {
      String accessToken = await LocalPref().getString("access_token");
      final response = await http.put(
        Uri.parse(AppConst.baseUrl + endpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + (accessToken.isNotEmpty ? accessToken : AppConst.anonToken),
        },
        body: jsonEncode(bodyJson),
      );

      return await verificationResponse(context, response, endpoint);
    } catch (e) {
      throw Exception(e);
    }
  }

// Make a DELETE request
  Future<ResponseApi?> requestDelete(BuildContext context, String endpoint) async {
    try {
      String accessToken = await LocalPref().getString("access_token");
      var response = await http.delete(
        Uri.parse(AppConst.baseUrl + endpoint),
        headers: <String, String>{'Authorization': 'Bearer ' + accessToken},
      );
      return await verificationResponse(context, response, endpoint);
    } catch (e) {
      throw Exception(e);
    }
  }

  // Make a POST request
  Future<ResponseApi> requestImagePost(
      BuildContext context, String endpoint, Map<String, Object> bodyJson) async {
    try {


      String accessToken = await LocalPref().getString("access_token");
      final dio = Dio();
      dio.options.contentType = "multipart/form-data";
      dio.options.headers["Authorization"] = "Bearer $accessToken";

      FormData formData = FormData.fromMap(
        bodyJson,
      );

      final response = await dio.post(
        AppConst.baseUrl + endpoint,
        data: formData,
      );

      print("$endpoint => Status : ${response.statusCode} Body : ${response.data}");

      return ResponseApi(status: response.statusCode ?? 400, body: response.data);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<ResponseApi?> verificationResponse(
      BuildContext context, dynamic response, String endpoint) async {
    print("$endpoint => Status : ${response.statusCode} Body : ${response.body}");

    if (response.statusCode >= 200 && response.statusCode <= 204) {
      return ResponseApi.fromRequest(response);
    } else {
      if (response.body.contains("message")) {
        if(jsonDecode(response.body)["message"] == "JWT expired" || jsonDecode(response.body)["message"] == "JWT is invalid") {
          SnackConst.SnackCustom("Session  expirée, veuillez vous reconnecter", context, duration: 3, color: Colors.red);
          LocalPref().saveString("access_token", "");
          LocalPref().saveString("refresh_token", "");
          LocalPref().saveString("uuid_user", "");
          Navigator.pushNamedAndRemoveUntil(context, "/Login", (route) => false);
        }
        // SnackConst.SnackCustom(jsonDecode(response.body)["message"], context,
        //     duration: 3, color: Colors.red);
      } else {
        SnackConst.SnackCustom(AppConst.errorApiMessage, context, duration: 3);
      }
    }
    return ResponseApi.fromRequest(response);

  }
}
