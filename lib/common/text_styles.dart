import 'package:flutter/material.dart';
import 'package:safe_nails/common/app_colors.dart';
import 'package:safe_nails/common/fonts.dart';

class TextStyles {

  final body = TextStyle(
    fontFamily: TTTravels.regular.familyName,
    fontWeight: TTTravels.regular.weight,
    fontSize: 16,
    fontStyle: FontStyle.normal,
    color: AppColors.primary,
  );

  final buttonText = TextStyle(
    fontFamily: Suprapower.bold.familyName,
    fontWeight: Suprapower.light.weight,
    color: AppColors.primary,
    fontStyle: FontStyle.normal,
    fontSize: 14,
  );

  final pageTitle = TextStyle(
    fontFamily: Suprapower.bold.familyName,
    fontWeight: Suprapower.light.weight,
    color: Colors.white,
    fontStyle: FontStyle.normal,
    fontSize: 14,
  );
}
