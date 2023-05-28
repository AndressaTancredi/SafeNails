import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safe_nails/common/app_colors.dart';
import 'package:safe_nails/common/injection_container.dart';
import 'package:safe_nails/common/text_styles.dart';
import 'package:safe_nails/ui/pages/home_page.dart';
import 'package:safe_nails/ui/pages/store_page.dart';
import 'package:safe_nails/ui/pages/tips_page.dart';

import '../bloc/analysis_bloc.dart';
import '../bloc/analysis_event.dart';

class HomeScreenPage extends StatefulWidget {
  @override
  _HomeScreenPageState createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  TextStyle get bodyDescription =>
      sl<TextStyles>().bodyDescription.copyWith(fontSize: 14.0);

  final analysisBloc = sl<AnalysisBloc>();

  int _actualIndex = 1;
  final List<Widget> _screens = [
    StorePage(),
    HomePage(),
    TipsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_actualIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: bodyDescription,
        elevation: 0,
        fixedColor: AppColors.pink,
        currentIndex: _actualIndex,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
              activeIcon: Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: SvgPicture.asset(
                  'assets/icons/shop.svg',
                  color: AppColors.pink,
                  height: 24,
                ),
              ),
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: SvgPicture.asset(
                  'assets/icons/shop.svg',
                  height: 20,
                  color: AppColors.black,
                ),
              ),
              label: "Loja"),
          BottomNavigationBarItem(
            activeIcon: Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: SvgPicture.asset(
                'assets/icons/scanner.svg',
                color: AppColors.pink,
                height: 30,
              ),
            ),
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: SvgPicture.asset(
                'assets/icons/scanner.svg',
                color: AppColors.black,
                height: 20,
              ),
            ),
            label: "Scanner",
          ),
          BottomNavigationBarItem(
            activeIcon: Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: SvgPicture.asset(
                'assets/icons/tips.svg',
                color: AppColors.pink,
                height: 30,
              ),
            ),
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: SvgPicture.asset(
                'assets/icons/tips.svg',
                height: 20,
                color: AppColors.black,
              ),
            ),
            label: "Dicas",
            backgroundColor: AppColors.pink,
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      if (_actualIndex == 1) {
        analysisBloc.add(ClearResultEvent());
      }
      _actualIndex = index;
    });
  }
}
