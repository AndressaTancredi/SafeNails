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
  TextStyle get title => sl<TextStyles>().pageTitle.copyWith(fontSize: 22.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(13.0 ),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: AppColors.pink)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 80.0,
                width: 80.0,
                padding: const EdgeInsets.all(23.0),
                decoration: BoxDecoration(
                  color: AppColors.backgroundIcon,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: SvgPicture.asset(
                  widget.iconPath,
                  color: AppColors.pink,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 34.0),
                child: Text(
                  widget.title,
                  style: title),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
