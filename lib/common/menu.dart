import 'package:flutter/material.dart';
import 'package:safe_nails/ui/pages/old_home_page.dart';
import 'package:safe_nails/ui/pages/test_page.dart';
import 'package:safe_nails/ui/pages/welcome_page.dart';

class AnimatedTabMenu extends StatefulWidget {
  static final List<IconData> icons = [
    Icons.home,
    Icons.search,
    Icons.person,
  ];

  static final List<Widget> pages = [
    const WelcomePage(),
    const OldHomePage(),
    const TestePage(),
  ];

  final Color? backgroundColor;

  const AnimatedTabMenu({
    super.key,
    this.backgroundColor,
  });

  @override
  _AnimatedTabMenuState createState() => _AnimatedTabMenuState();
}

class _AnimatedTabMenuState extends State<AnimatedTabMenu>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: AnimatedTabMenu.icons.length,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: _tabController,
        children: AnimatedTabMenu.pages,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 10,
              offset: Offset(0, 3),
            ),
          ],
          color: widget.backgroundColor,
        ),
        child: TabBar(
          controller: _tabController,
          tabs: AnimatedTabMenu.icons
              .map((icon) => Tab(
            icon: Icon(icon),
          ))
              .toList(),
        ),
      ),
    );
  }
}
