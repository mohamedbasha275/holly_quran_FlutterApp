import 'package:flutter/material.dart';
import 'package:holly_quran/core/resources/app_colors.dart';
import 'package:holly_quran/core/resources/app_constants.dart';
import 'package:holly_quran/core/resources/values_manager.dart';

SnackBar buildSnackBar(BuildContext context, {required String title}) {
  return SnackBar(
    duration: const Duration(
        milliseconds: AppConstants.snackBarSpeedTime),
    backgroundColor: AppColors.primary,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(AppSize.s20),
        topLeft: Radius.circular(AppSize.s20),
      ),
    ),
    content: Text(title,
      style: Theme.of(context).textTheme.titleSmall,
      textAlign: TextAlign.center,
    ),
  );
}