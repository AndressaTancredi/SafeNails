import 'package:flutter/material.dart';

import '../page/home_page.dart';

class AppRouter {
  Route onGeneratedRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/home':
        return MaterialPageRoute(builder: (_) => HomePage());
      default:
        throw ArgumentError('Inexistent route: s${routeSettings.name}');
      }
    }
  }