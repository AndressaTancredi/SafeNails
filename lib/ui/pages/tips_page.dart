import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safe_nails/common/app_colors.dart';
import 'package:safe_nails/common/common_strings.dart';
import 'package:safe_nails/common/injection_container.dart';
import 'package:safe_nails/common/text_styles.dart';
import 'package:safe_nails/data/datasources/tips_data.dart';
import 'package:safe_nails/ui/bloc/tips/tips_bloc.dart';
import 'package:safe_nails/ui/bloc/tips/tips_state.dart';
import 'package:safe_nails/ui/widgets/banner_ad.dart';
import 'package:safe_nails/ui/widgets/category_tip.dart';

class TipsPage extends StatefulWidget {
  const TipsPage({Key? key}) : super(key: key);

  @override
  State<TipsPage> createState() => _TipsPageState();
}

class _TipsPageState extends State<TipsPage> {
  TextStyle get title => sl<TextStyles>().pageTitle;
  TextStyle get bodyDescription => sl<TextStyles>().bodyDescription;
  final tipsBloc = sl<TipsBloc>();

  @override
  Widget build(BuildContext context) {
    Color titleColor = AppColors.primary;
    List<Color> backgroundColor = [Colors.white, Colors.white70];
    Color iconBackgroundColor = AppColors.background;

    Color focusTitleColor = Colors.white;
    List<Color> focusBackgroundColor = AppColors.categoryTipBackgroundColor;
    Color focusIconBackgroundColor = Colors.white;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.background,
          title: Text(CommonStrings.careTips, style: title),
          centerTitle: true,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 8),
            child: Column(
              children: [
                BlocBuilder<TipsBloc, TipsState>(
                  bloc: tipsBloc,
                  builder: (context, state) {
                    if (state is HydrationState) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  tipsBloc.emit(HydrationState());
                                },
                                child: CategoryTip(
                                  title: CommonStrings.hydration,
                                  icon: "assets/icons/hydration.svg",
                                  titleColor: focusTitleColor,
                                  backgroundColor: focusBackgroundColor,
                                  iconBackgroundColor: focusIconBackgroundColor,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  tipsBloc.emit(CleansingState());
                                },
                                child: CategoryTip(
                                  title: CommonStrings.cleansing,
                                  icon: "assets/icons/cleansing.svg",
                                  titleColor: titleColor,
                                  backgroundColor: backgroundColor,
                                  iconBackgroundColor: iconBackgroundColor,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  tipsBloc.emit(ProtectionState());
                                },
                                child: CategoryTip(
                                  title: CommonStrings.protection,
                                  icon: "assets/icons/protection.svg",
                                  titleColor: titleColor,
                                  backgroundColor: backgroundColor,
                                  iconBackgroundColor: iconBackgroundColor,
                                ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Text.rich(
                                          TextSpan(
                                            style: bodyDescription.copyWith(
                                                fontSize: 14),
                                            children: [
                                              WidgetSpan(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8.0),
                                                  child: SvgPicture.asset(
                                                    "assets/icons/circle_tip.svg",
                                                    color: AppColors.pink,
                                                    height: 16,
                                                  ),
                                                ),
                                              ),
                                              TextSpan(
                                                  text: TipsData
                                                      .hydrationTips[index]),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }
                    if (state is CleansingState) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  tipsBloc.emit(HydrationState());
                                },
                                child: CategoryTip(
                                    title: CommonStrings.hydration,
                                    icon: "assets/icons/hydration.svg",
                                    titleColor: titleColor,
                                    backgroundColor: backgroundColor,
                                    iconBackgroundColor: iconBackgroundColor),
                              ),
                              GestureDetector(
                                onTap: () {
                                  tipsBloc.emit(CleansingState());
                                },
                                child: CategoryTip(
                                  title: CommonStrings.cleansing,
                                  icon: "assets/icons/cleansing.svg",
                                  titleColor: focusTitleColor,
                                  backgroundColor: focusBackgroundColor,
                                  iconBackgroundColor: focusIconBackgroundColor,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  tipsBloc.emit(ProtectionState());
                                },
                                child: CategoryTip(
                                  title: CommonStrings.protection,
                                  icon: "assets/icons/protection.svg",
                                  titleColor: titleColor,
                                  backgroundColor: backgroundColor,
                                  iconBackgroundColor: iconBackgroundColor,
                                ),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Text.rich(
                                          TextSpan(
                                            style: bodyDescription.copyWith(
                                                fontSize: 14),
                                            children: [
                                              WidgetSpan(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8.0,
                                                          bottom: 2),
                                                  child: SvgPicture.asset(
                                                    "assets/icons/circle_tip.svg",
                                                    color: AppColors.pink,
                                                    height: 16,
                                                  ),
                                                ),
                                              ),
                                              TextSpan(
                                                  text: TipsData
                                                      .cleansingTips[index]),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    }
                    if (state is ProtectionState) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  tipsBloc.emit(HydrationState());
                                },
                                child: CategoryTip(
                                  title: CommonStrings.hydration,
                                  icon: "assets/icons/hydration.svg",
                                  titleColor: titleColor,
                                  backgroundColor: backgroundColor,
                                  iconBackgroundColor: iconBackgroundColor,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  tipsBloc.emit(CleansingState());
                                },
                                child: CategoryTip(
                                  title: CommonStrings.cleansing,
                                  icon: "assets/icons/cleansing.svg",
                                  titleColor: titleColor,
                                  backgroundColor: backgroundColor,
                                  iconBackgroundColor: iconBackgroundColor,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  tipsBloc.emit(ProtectionState());
                                },
                                child: CategoryTip(
                                  title: CommonStrings.protection,
                                  icon: "assets/icons/protection.svg",
                                  titleColor: focusTitleColor,
                                  backgroundColor: focusBackgroundColor,
                                  iconBackgroundColor: focusIconBackgroundColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 24.0),
                          SingleChildScrollView(
                            child: Container(
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: Text.rich(
                                            TextSpan(
                                              style: bodyDescription.copyWith(
                                                  fontSize: 14),
                                              children: [
                                                WidgetSpan(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8.0,
                                                            bottom: 2),
                                                    child: SvgPicture.asset(
                                                      "assets/icons/circle_tip.svg",
                                                      color: AppColors.pink,
                                                      height: 16,
                                                    ),
                                                  ),
                                                ),
                                                TextSpan(
                                                    text: TipsData
                                                        .protectionTips[index]),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    return SizedBox.shrink();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: BannerAdmob(
                    idAdMob: 'ca-app-pub-6850065566204568/8231464109',
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
