import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safe_nails/common/app_colors.dart';
import 'package:safe_nails/common/common_strings.dart';
import 'package:safe_nails/common/injection_container.dart';
import 'package:safe_nails/common/text_styles.dart';
import 'package:safe_nails/ui/bloc/analysis/analysis_bloc.dart';
import 'package:safe_nails/ui/bloc/analysis/analysis_event.dart';
import 'package:safe_nails/ui/pages/home_page.dart';
import 'package:safe_nails/ui/pages/profile_page.dart';
import 'package:safe_nails/ui/pages/tips_page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class HomeMenu extends StatefulWidget {
  @override
  _HomeMenuState createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  TextStyle get bodyDescription =>
      sl<TextStyles>().bodyDescription.copyWith(fontSize: 14.0);

  final analysisBloc = sl<AnalysisBloc>();

  int _actualIndex = 1;
  final List<Widget> _screens = [
    ProfilePage(),
    HomePage(),
    TipsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_actualIndex],
      bottomNavigationBar: SalomonBottomBar(
        itemPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 8),
        currentIndex: _actualIndex,
        onTap: onTabTapped,
        items: [
          /// Profile
          SalomonBottomBarItem(
            icon: Icon(
              Icons.person_outline,
              size: 30,
              color: _actualIndex == 0 ? AppColors.pink : AppColors.softGrey,
            ),
            title: Text(CommonStrings.profileTitle),
            selectedColor: AppColors.pink,
          ),

          /// Scanner
          SalomonBottomBarItem(
            icon: SvgPicture.asset(
              'assets/icons/scanner.svg',
              color: _actualIndex == 1 ? AppColors.pink : AppColors.softGrey,
            ),
            title: Text(CommonStrings.scannerTitle),
            selectedColor: AppColors.pink,
          ),

          /// Tips
          SalomonBottomBarItem(
            icon: SvgPicture.asset(
              'assets/icons/tips.svg',
              color: _actualIndex == 2 ? AppColors.pink : AppColors.softGrey,
            ),
            title: Text(CommonStrings.tipsTitle),
            selectedColor: AppColors.pink,
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      analysisBloc.add(ClearResultEvent());
      _actualIndex = index;
    });
  }
}
