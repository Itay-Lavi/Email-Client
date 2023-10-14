import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

void showFlushBar(
    BuildContext context, String title, String message, Color color) {
  Flushbar(
    maxWidth: 350,
    margin: const EdgeInsets.all(8),
    borderRadius: BorderRadius.circular(8),
    backgroundColor: color,
    title: title,
    message: message,
    duration: const Duration(seconds: 3),
  ).show(context);
}
