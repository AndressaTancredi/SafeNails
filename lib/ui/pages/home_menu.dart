import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safe_nails/common/app_colors.dart';
import 'package:safe_nails/common/injection_container.dart';
import 'package:safe_nails/common/text_styles.dart';
import 'package:safe_nails/ui/bloc/analysis/analysis_bloc.dart';
import 'package:safe_nails/ui/bloc/analysis/analysis_event.dart';
import 'package:safe_nails/ui/pages/home_page.dart';
import 'package:safe_nails/ui/pages/profile_page.dart';
import 'package:safe_nails/ui/pages/tips_page.dart';

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
              child: Icon(
                Icons.account_circle_outlined,
                color: AppColors.pink,
                size: 30,
              ),
            ),
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Icon(
                Icons.account_circle_outlined,
                color: AppColors.softGrey,
                size: 30,
              ),
            ),
            label: "Perfil",
          ),
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
      analysisBloc.add(ClearResultEvent());
      _actualIndex = index;
    });
  }
}
