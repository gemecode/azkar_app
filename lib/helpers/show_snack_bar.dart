import 'package:azkar_app/helpers/app_theme.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, {required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Center(child: Text(message)),
    backgroundColor: AppTheme.lightTheme.primaryColor,
  ));
}
