import 'package:flutter/material.dart';

MySnackBar(context, message) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(2)),
      behavior: SnackBarBehavior.floating,
      clipBehavior: Clip.antiAlias,
      duration: const Duration(seconds: 3),
      backgroundColor: const Color(0xFF34B233),
      content: Text(message),
    ),
  );
}
