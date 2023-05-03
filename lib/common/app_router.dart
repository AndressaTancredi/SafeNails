import 'package:flutter/material.dart';

import 'package:safe_nails/page/old_home_page.dart';

class AppRouter {
  Route onGeneratedRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/old_home':
        return MaterialPageRoute(builder: (_) => const OldHomePage());
      default:
        throw ArgumentError('Inexistent route: s${routeSettings.name}');
      }
    }
  }
