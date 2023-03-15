import 'package:flutter/material.dart';

void showSnackbar({required BuildContext context, required String message, int? duration}) {
  final snackBar = SnackBar(
    content: Text(message),
    duration: Duration(milliseconds: duration ?? 5000),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
