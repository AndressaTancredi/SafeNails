import 'package:flutter/material.dart';
import 'package:safe_nails/common/app_colors.dart';
import 'package:safe_nails/common/injection_container.dart';
import 'package:safe_nails/common/text_styles.dart';

class ImageSource extends StatefulWidget {
  final String title;
  final IconData icon;
  const ImageSource({super.key, required this.title, required this.icon});

  @override
  State<ImageSource> createState() => _ImageSourceState();
}

class _ImageSourceState extends State<ImageSource> {
  TextStyle get titlePageStyle => sl<TextStyles>().pageTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0 ),
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
                height: 60.0,
                width: 60.0,
                padding: const EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Icon(
                    widget.icon,
                    color: AppColors.pink,
                    size: 25.0
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 34.0),
                child: Text(
                  widget.title,
                  style: titlePageStyle.copyWith(fontSize: 20.0),),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
