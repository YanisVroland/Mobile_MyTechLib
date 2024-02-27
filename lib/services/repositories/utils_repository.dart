import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../../app/theme/app_const.dart';
import 'package:http/http.dart' as http;

import '../../app/theme/snackBar_const.dart';
import '../local/pref.dart';
import '../models/responseAPI_model.dart';

class UtilsRepository {
  Future<void> getDefaultData(Map<String, Object> bodyJson) async {
    String uuidDevice = await LocalPref().getString("uuidDevice");
    if (uuidDevice.isEmpty) {
      uuidDevice = const Uuid().v4();
      await LocalPref().saveString("uuidDevice", uuidDevice);
    }

    String nameEmployee = await LocalPref().getString("nameEmployee");
    String idEmployee = await LocalPref().getString("idEmployee");

    bodyJson.putIfAbsent('uuidDevice', () => uuidDevice);
    bodyJson.putIfAbsent('idEmployee', () => idEmployee);
    bodyJson.putIfAbsent('nameEmployee', () => nameEmployee);
    bodyJson.putIfAbsent('version', () => "V1.0.0");
  }

  Future<ResponseApi?> requestPost(
      BuildContext context, String endpoint, Map<String, Object> bodyJson) async {
    try {
      await getDefaultData(bodyJson);
      final response = await http.post(
        Uri.parse(AppConst.baseUrl + endpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + AppConst.anonToken,
        },
        body: jsonEncode(bodyJson),
      );

      return await verificationResponse(context, response, endpoint);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<ResponseApi?> requestGet(BuildContext context, String endpoint) async {
    try {
      var url = Uri.parse(AppConst.baseUrl + endpoint);
      var response = await http.get(url);
      return await verificationResponse(context, response, endpoint);
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<ResponseApi?> verificationResponse(BuildContext context, dynamic response, String endpoint) async {
    print("$endpoint => Status : ${response.statusCode} Body : ${response.body}");

    if (response.statusCode >= 200 && response.statusCode <= 204) {
      if (response.statusCode == 204) {
        SnackConst.SnackCustom(AppConst.missingDataMessage, context,
            duration: 3, color: Colors.blue);
      }
      return ResponseApi.fromRequest(response);
    } else {
      if (response.body.contains("message")) {
        SnackConst.SnackCustom(jsonDecode(response.body)["message"], context,
            duration: 3, color: Colors.red);
      } else {
        SnackConst.SnackCustom(AppConst.errorApiMessage, context, duration: 3);
      }
    }
  }
}
