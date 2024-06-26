import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safe_nails/common/analytics.dart';
import 'package:safe_nails/common/app_colors.dart';
import 'package:safe_nails/common/common_strings.dart';
import 'package:safe_nails/common/injection_container.dart';
import 'package:safe_nails/common/text_styles.dart';
import 'package:safe_nails/data/tips_data.dart';
import 'package:safe_nails/ui/bloc/tips/tips_bloc.dart';
import 'package:safe_nails/ui/bloc/tips/tips_event.dart';
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

  final String bannerId = Platform.isAndroid
      ? dotenv.env['ANDROID_BANNER_ID']!
      : dotenv.env['IOS_BANNER_ID']!;

  Map<String, List<int>> _randomTipsIndexes = {
    'hydration': [],
    'cleansing': [],
    'protection': [],
  };

  @override
  void initState() {
    super.initState();
    _generateRandomTipsIndexes('hydration');
    _generateRandomTipsIndexes('cleansing');
    _generateRandomTipsIndexes('protection');
    sl<Analytics>().onScreenView(AnalyticsEventTags.tips_page);
  }

  void _generateRandomTipsIndexes(String category) {
    final random = Random();
    final totalTips = {
      'hydration': TipsData.hydrationTips.length,
      'cleansing': TipsData.cleansingTips.length,
      'protection': TipsData.protectionTips.length,
    }[category]!;

    while (_randomTipsIndexes[category]!.length < 3) {
      final randomIndex = random.nextInt(totalTips);
      if (!_randomTipsIndexes[category]!.contains(randomIndex)) {
        _randomTipsIndexes[category]!.add(randomIndex);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.background,
          title: Text(CommonStrings.careTipsTitle, style: title),
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
                      return _buildCategory('hydration');
                    } else if (state is CleansingState) {
                      return _buildCategory('cleansing');
                    } else if (state is ProtectionState) {
                      return _buildCategory('protection');
                    }
                    return SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategory(String category) {
    final titleColor = AppColors.primary;
    final backgroundColor = [Colors.white, Colors.white70];
    final iconBackgroundColor = AppColors.background;

    final focusTitleColor = Colors.white;
    final focusBackgroundColor = AppColors.categoryTipBackgroundColor;
    final focusIconBackgroundColor = Colors.white;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                tipsBloc.add(HydrationEvent());
                _generateRandomTipsIndexes('hydration');
              },
              child: CategoryTip(
                title: CommonStrings.hydration,
                icon: "assets/icons/hydration.svg",
                titleColor:
                    category == 'hydration' ? focusTitleColor : titleColor,
                backgroundColor: category == 'hydration'
                    ? focusBackgroundColor
                    : backgroundColor,
                iconBackgroundColor: category == 'hydration'
                    ? focusIconBackgroundColor
                    : iconBackgroundColor,
              ),
            ),
            GestureDetector(
              onTap: () {
                tipsBloc.add(CleansingEvent());
                _generateRandomTipsIndexes('cleansing');
              },
              child: CategoryTip(
                title: CommonStrings.cleansing,
                icon: "assets/icons/cleansing.svg",
                titleColor:
                    category == 'cleansing' ? focusTitleColor : titleColor,
                backgroundColor: category == 'cleansing'
                    ? focusBackgroundColor
                    : backgroundColor,
                iconBackgroundColor: category == 'cleansing'
                    ? focusIconBackgroundColor
                    : iconBackgroundColor,
              ),
            ),
            GestureDetector(
              onTap: () {
                tipsBloc.add(ProtectionEvent());
                _generateRandomTipsIndexes('protection');
              },
              child: CategoryTip(
                title: CommonStrings.protection,
                icon: "assets/icons/protection.svg",
                titleColor:
                    category == 'protection' ? focusTitleColor : titleColor,
                backgroundColor: category == 'protection'
                    ? focusBackgroundColor
                    : backgroundColor,
                iconBackgroundColor: category == 'protection'
                    ? focusIconBackgroundColor
                    : iconBackgroundColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 14.0),
          child: BannerAdmob(
            idAdMob: bannerId,
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context, index) {
              final tipIndex = _randomTipsIndexes[category]![index];
              final tipText = {
                'hydration': TipsData.hydrationTips[tipIndex],
                'cleansing': TipsData.cleansingTips[tipIndex],
                'protection': TipsData.protectionTips[tipIndex],
              }[category];
              return Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text.rich(
                            TextSpan(
                              style: bodyDescription.copyWith(fontSize: 14),
                              children: [
                                WidgetSpan(
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      right: 8.0,
                                    ),
                                    child: SvgPicture.asset(
                                      "assets/icons/circle_tip.svg",
                                      color: AppColors.pink,
                                      height: 16,
                                    ),
                                  ),
                                ),
                                TextSpan(text: tipText),
                              ],
                            ),
                          ),
                        ),
                      ],
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
}
