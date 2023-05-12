import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safe_nails/common/app_colors.dart';
import 'package:safe_nails/common/common_strings.dart';
import 'package:safe_nails/common/injection_container.dart';
import 'package:safe_nails/common/text_styles.dart';

import 'button.dart';

class Result extends StatefulWidget {
  final bool positiveResult;
  const Result({required this.positiveResult});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  TextStyle get title => sl<TextStyles>().pageTitle;
  TextStyle get bodyDescription => sl<TextStyles>().bodyDescription;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(14.0),
          height: 350,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0)
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Image.asset(
              'assets/images/nail_polish_ingredients.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(14.0 ),
            height: 110,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                      CommonStrings.result,
                      style: title
                  ),
                ),
                _valueResult(positiveResult: widget.positiveResult)
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          Center(child: Button(buttonText: CommonStrings.restarted, routePath: '/welcome_page'))
        ],
      ),
    ]
    );
  }

  Widget _valueResult({required bool positiveResult}) {
    String iconPath;
    Color? textColor;

    if (positiveResult == true) {
      iconPath = "assets/icons/tick_circle.svg";
      textColor = AppColors.green;
    } else {
      iconPath = "assets/icons/close_circle.svg";
      textColor = AppColors.red;
    }

    return Row(
      children: [
        SvgPicture.asset(iconPath),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            CommonStrings.safeResult,
            style: bodyDescription.copyWith(color: textColor),
          ),
        ),
      ],
    );
  }
}
