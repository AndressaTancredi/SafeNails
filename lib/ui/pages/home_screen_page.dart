import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safe_nails/ui/pages/home_page.dart';
import 'package:safe_nails/ui/pages/store_page.dart';
import 'package:safe_nails/ui/pages/tips_page.dart';

class HomeScreenPage extends StatefulWidget {
  @override
  _HomeScreenPageState createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends State<HomeScreenPage> {
  int _indiceAtual = 1;
  final List<Widget> _telas = [
    StorePage(),
    HomePage(),
    TipsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _telas[_indiceAtual],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _indiceAtual,
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/shop.svg'), label: "Loja"),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/scanner.svg'),
              label: "Scanner"),
          BottomNavigationBarItem(
              icon: SvgPicture.asset('assets/icons/tips.svg'), label: "Dicas"),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _indiceAtual = index;
    });
  }
}
