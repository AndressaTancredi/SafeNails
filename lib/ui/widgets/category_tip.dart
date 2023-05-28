import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safe_nails/common/injection_container.dart';
import 'package:safe_nails/common/text_styles.dart';

class CategoryTip extends StatelessWidget {
  final Color titleColor;
  final List<Color> backgroundColor;
  final Color iconBackgroundColor;
  final String title;
  final String icon;
  const CategoryTip(
      {Key? key,
      required this.title,
      required this.icon,
      required this.titleColor,
      required this.backgroundColor,
      required this.iconBackgroundColor})
      : super(key: key);
  TextStyle get bodyDescription => sl<TextStyles>().bodyDescription;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 108,
      width: 104,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: backgroundColor
            // Color(0xffF3BABC),
            // Color(0xffE79597).withOpacity(0.8),

            ),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        children: [
          Expanded(
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: iconBackgroundColor, shape: BoxShape.circle),
              child: SvgPicture.asset(
                icon,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Text(
              title,
              style: bodyDescription.copyWith(color: titleColor, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
