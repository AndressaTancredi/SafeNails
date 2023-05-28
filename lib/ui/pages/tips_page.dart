import 'package:flutter/material.dart';
import 'package:safe_nails/common/app_colors.dart';
import 'package:safe_nails/common/common_strings.dart';
import 'package:safe_nails/common/injection_container.dart';
import 'package:safe_nails/common/text_styles.dart';
import 'package:safe_nails/ui/widgets/category_card.dart';

class TipsPage extends StatefulWidget {
  const TipsPage({Key? key}) : super(key: key);

  @override
  State<TipsPage> createState() => _TipsPageState();
}

class _TipsPageState extends State<TipsPage> {
  TextStyle get title => sl<TextStyles>().pageTitle;

  @override
  Widget build(BuildContext context) {
    Color titleColor = AppColors.primary;
    List<Color> backgroundColor = [Colors.white, Colors.white70];
    Color iconBackgroundColor = AppColors.background;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.background,
          title: Text(CommonStrings.careTips, style: title),
          centerTitle: true,
          elevation: 0,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black54,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: CategoryCard(
                    title: CommonStrings.hydration,
                    icon: "assets/icons/hydration.svg",
                    titleColor: titleColor,
                    backgroundColor: backgroundColor,
                    iconBackgroundColor: AppColors.background,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      backgroundColor = [
                        Color(0xffF3BABC),
                        Color(0xffE79597).withOpacity(0.8)
                      ];
                    });
                  },
                  child: CategoryCard(
                    title: CommonStrings.cleansing,
                    icon: "assets/icons/cleansing.svg",
                    titleColor: titleColor,
                    backgroundColor: backgroundColor,
                    iconBackgroundColor: iconBackgroundColor,
                  ),
                ),
                CategoryCard(
                  title: CommonStrings.protection,
                  icon: "assets/icons/protection.svg",
                  titleColor: titleColor,
                  backgroundColor: backgroundColor,
                  iconBackgroundColor: iconBackgroundColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
