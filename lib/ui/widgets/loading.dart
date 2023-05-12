import 'package:flutter/material.dart';
import 'package:safe_nails/common/app_colors.dart';
import 'package:safe_nails/common/common_strings.dart';
import 'package:safe_nails/common/injection_container.dart';
import 'package:safe_nails/common/text_styles.dart';
import 'package:shimmer/shimmer.dart';

class Loading extends StatefulWidget {
  const Loading();

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  TextStyle get title => sl<TextStyles>().pageTitle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
                CommonStrings.loadingMessage,
                style: title
            ),
          ),
          Container(
            padding: const EdgeInsets.all(14.0 ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.0)
            ),
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade200,
              highlightColor: AppColors.background,
              child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0)
                ),
                height: 110,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
