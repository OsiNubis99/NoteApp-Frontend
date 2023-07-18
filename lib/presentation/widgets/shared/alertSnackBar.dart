import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';

SnackBar AlertSnackBar(
    {required String titulo,
    required String mensaje,
    required ContentType tipo}) {
  final snackBar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: titulo,
      message: mensaje,
      contentType: tipo,
    ),
  );
  return snackBar;
}
