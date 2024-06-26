import 'package:flutter/material.dart';
import 'package:safe_nails/common/app_colors.dart';

class TextStyles {
  final principalTitle = const TextStyle(
      fontFamily: "Cosmetic",
      fontWeight: FontWeight.w900,
      color: AppColors.black,
      fontStyle: FontStyle.normal,
      fontSize: 44);

  final principalSubTitle = const TextStyle(
    fontFamily: "DMSans",
    fontWeight: FontWeight.w400,
    color: AppColors.regularGrey,
    fontStyle: FontStyle.normal,
    fontSize: 18,
  );

  final buttonText = const TextStyle(
    fontFamily: "DMSans",
    fontWeight: FontWeight.w700,
    color: AppColors.black,
    fontStyle: FontStyle.normal,
    fontSize: 18,
  );

  final pageTitle = const TextStyle(
    fontFamily: "Cosmetic",
    fontWeight: FontWeight.w700,
    color: AppColors.regularBlack,
    fontStyle: FontStyle.normal,
    fontSize: 24,
  );

  final subTitle = const TextStyle(
    fontFamily: "Cosmetic",
    fontWeight: FontWeight.w700,
    color: AppColors.boldBlack,
    fontStyle: FontStyle.normal,
    fontSize: 14,
  );

  final bodyDescription = const TextStyle(
    fontFamily: "DMSans",
    fontWeight: FontWeight.w400,
    color: AppColors.lightGrey,
    fontStyle: FontStyle.normal,
    fontSize: 14,
  );

  final resultBody = const TextStyle(
    fontFamily: "DMSans",
    fontWeight: FontWeight.w400,
    color: AppColors.softGrey,
    fontStyle: FontStyle.normal,
    fontSize: 12,
  );

  final body = const TextStyle(
    fontFamily: "Cosmetic",
    fontWeight: FontWeight.w900,
    fontSize: 12,
    fontStyle: FontStyle.normal,
    color: AppColors.primary,
  );

  final linkText = const TextStyle(
      fontFamily: "DMSans",
      fontWeight: FontWeight.w500,
      fontSize: 12,
      color: AppColors.blue,
      decoration: TextDecoration.underline);

  final inputText = TextStyle(
      fontFamily: "DMSans",
      fontWeight: FontWeight.w300,
      fontSize: 20,
      color: AppColors.lightestGrey);
}
