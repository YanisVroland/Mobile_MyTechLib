/*
  This file contains a utility class for displaying custom SnackBars.
*/

import 'package:flutter/material.dart';

class SnackConst {
  // Method to display a custom SnackBar
  static SnackCustom(
      String text,
      BuildContext context, {
        int duration = 2,
        Color color = Colors.red,
        onPresse,
      }) {
    SnackBar? snackbar = SnackBar(
      content: Text(text.toString()),
      backgroundColor: color,
      duration: Duration(seconds: duration),
      action: SnackBarAction(
        label: 'Fermer',
        textColor: Colors.white,
        onPressed: () {
          // If onPresse function is provided, execute it; otherwise, hide the current SnackBar
          onPresse ?? ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );
    // Show the SnackBar and handle its closing
    ScaffoldMessenger.of(context)
        .showSnackBar(snackbar)
        .closed
        .then((_value) => snackbar = null);
  }
}
