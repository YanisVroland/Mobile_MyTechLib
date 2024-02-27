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

  Future<ResponseApi> requestPost(
      BuildContext context, String endpoint, Map<String, Object> bodyJson) async {
    try {
      await getDefaultData(bodyJson);
      final response = await http.post(
        Uri.parse(AppConst.baseUrl + endpoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(bodyJson),
      );

      return await verificationResponse(context, response, endpoint);
    } catch (e) {
      throw Exception(e);
    }
  }


  Future<ResponseApi> requestGet(BuildContext context, String endpoint) async {
    try {
      var url = Uri.parse(AppConst.baseUrl + endpoint);
      var response = await http.get(url);
      return await verificationResponse(context, response, endpoint);
    } catch (e) {
      throw Exception(e);
    }
  }

  verificationResponse(BuildContext context, response, String endpoint) async {
    print("$endpoint => Status : ${response.statusCode} Body : ${response.body}");

    if(response.statusCode < 200 || response.statusCode > 204){
      SnackConst.SnackCustom(AppConst.errorApiMessage, context, duration: 3);
    }else if(response.statusCode == 204){
      SnackConst.SnackCustom(AppConst.missingDataMessage, context, duration: 3,color: Colors.blue);
    }
    switch (response.statusCode) {
      case (406):
        // await showDialog(
        //     barrierDismissible: false,
        //     context: context,
        //     builder: (context) {
        //       return CustomDialogBoxInfo(
        //           title: "Appareil déconnecté",
        //           descriptions: "Compte utilisé sur un autre appareil.",
        //           positiveLabelButton: "Se reconnecter",
        //           positivePressed: () async {
        //             await LocalPref().saveString("idEmployee", "");
        //             Navigator.pushNamedAndRemoveUntil(
        //                 context, '/Login', (Route<dynamic> route) => false);
        //           });
        //     });
        break;
      case (501):
        //TODO BLOQUER UI
        break;
      default:
        return ResponseApi.fromRequest(response);
    }
  }

}
