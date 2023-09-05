import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safe_nails/common/app_colors.dart';
import 'package:safe_nails/common/injection_container.dart';
import 'package:safe_nails/common/text_styles.dart';

class ImageSource extends StatefulWidget {
  final String title;
  final String iconPath;
  const ImageSource({super.key, required this.title, required this.iconPath});

  @override
  State<ImageSource> createState() => _ImageSourceState();
}

class _ImageSourceState extends State<ImageSource> {
  TextStyle get subTitle => sl<TextStyles>().subTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: AppColors.pink)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.title,
              style: subTitle,
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
            decoration: BoxDecoration(
              color: AppColors.backgroundIcon,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: SvgPicture.asset(
              widget.iconPath,
              color: AppColors.pink,
            ),
          ),
          SizedBox(height: 14),
        ],
      ),
    );
  }
}
