import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/color_const.dart';

class Alerts {
  static alert_image(context, Function onTap) {
    Alert(
      context: context,
      image: Container(),
      title: "Supprimer ?",
      desc: "Voulez-vous vraiment supprimer cette image ?",
      buttons: [
        DialogButton(
          color: Colors.black,
          child: Text(
            "Non",
            style: TextStyle(color: Colors.white, fontSize: 15.5.sp),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          width: 12.w,
        ),
        DialogButton(
          color: ColorConst.primary,
          child: const Text(
            "Oui",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            onTap();
            Navigator.pop(context);
          },
          width: 120.w,
        )
      ],
    ).show();
  }
}
