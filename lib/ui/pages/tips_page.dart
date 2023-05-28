import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safe_nails/common/app_colors.dart';
import 'package:safe_nails/common/common_strings.dart';
import 'package:safe_nails/common/injection_container.dart';
import 'package:safe_nails/common/text_styles.dart';
import 'package:safe_nails/data/datasources/tips_data.dart';
import 'package:safe_nails/ui/widgets/category_tip.dart';

class TipsPage extends StatefulWidget {
  const TipsPage({Key? key}) : super(key: key);

  @override
  State<TipsPage> createState() => _TipsPageState();
}

class _TipsPageState extends State<TipsPage> {
  TextStyle get title => sl<TextStyles>().pageTitle;
  TextStyle get bodyDescription => sl<TextStyles>().bodyDescription;

  @override
  Widget build(BuildContext context) {
    Color titleColor = AppColors.primary;
    List<Color> backgroundColor = [Colors.white, Colors.white70];
    Color iconBackgroundColor = AppColors.background;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
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
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CategoryTip(
                      title: CommonStrings.hydration,
                      icon: "assets/icons/hydration.svg",
                      titleColor: titleColor,
                      backgroundColor: backgroundColor,
                      iconBackgroundColor: AppColors.background,
                    ),
                    CategoryTip(
                      title: CommonStrings.cleansing,
                      icon: "assets/icons/cleansing.svg",
                      titleColor: titleColor,
                      backgroundColor: backgroundColor,
                      iconBackgroundColor: iconBackgroundColor,
                    ),
                    CategoryTip(
                      title: CommonStrings.protection,
                      icon: "assets/icons/protection.svg",
                      titleColor: titleColor,
                      backgroundColor: backgroundColor,
                      iconBackgroundColor: iconBackgroundColor,
                    ),
                  ],
                ),
                SizedBox(height: 24.0),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: TipsData.hydrationTips.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 10.0, top: 4),
                              child: SvgPicture.asset(
                                "assets/icons/circle_tip.svg",
                                color: AppColors.pink,
                                height: 16,
                              ),
                            ),
                            Flexible(
                                child: Text(
                              TipsData.protectionTips[index],
                              style: bodyDescription,
                            )),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
