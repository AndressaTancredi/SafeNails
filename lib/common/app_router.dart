import 'package:flutter/material.dart';
import 'package:safe_nails/ui/pages/old_home_page.dart';
import 'package:safe_nails/ui/pages/welcome_page.dart';

class AppRouter {
  Route onGeneratedRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/old_home':
        return MaterialPageRoute(builder: (_) => const OldHomePage());
      case '/home_page':
        return MaterialPageRoute(builder: (_) => const WelcomePage());
      default:
        throw ArgumentError('Inexistent route: s${routeSettings.name}');
      }
    }
  }
