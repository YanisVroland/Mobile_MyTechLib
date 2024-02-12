import 'package:flutter/material.dart';

class SnackConst {
  static SnackCustom(String text, BuildContext context,
      {int duration = 2, Color color = Colors.red, onPresse = null}) {
    SnackBar? snackbar = SnackBar(
      content: Text(text.toString()),
      backgroundColor: color,
      duration: Duration(seconds: duration),
      action: SnackBarAction(
        label: 'Fermer',
        textColor: Colors.white,
        onPressed: () {
          onPresse ?? ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );
    ScaffoldMessenger.of(context)
        .showSnackBar(snackbar)
        .closed
        .then((_value) => snackbar = null);
  }
}
