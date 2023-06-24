import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class CommonMethod {
  static void showToast(BuildContext context, String message) {
    var snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(message),
      backgroundColor: Colors.black,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void showFlushBar(BuildContext context, String message) {
    Flushbar(
      backgroundColor: Colors.black,
      message: message,
      duration: const Duration(seconds: 2),
    ).show(context);
  }
}
