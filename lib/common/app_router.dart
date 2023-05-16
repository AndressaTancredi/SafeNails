import 'package:flutter/material.dart';
import 'package:safe_nails/ui/pages/home_page.dart';
import 'package:safe_nails/ui/pages/result_detail.dart';
import 'package:safe_nails/ui/pages/welcome_page.dart';

class AppRouter {
  Route onGeneratedRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/welcome_page':
        return MaterialPageRoute(builder: (_) => const WelcomePage());
      case '/home_page':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/result_detail':
        return MaterialPageRoute(
            builder: (_) => ResultDetail(
                unhealthyIngredientsFounded2:
                    routeSettings.arguments! as Map<String, List<String>>,
                photo: routeSettings.arguments! as Map<String, List<String>>));
      default:
        throw ArgumentError('Inexistent route: s${routeSettings.name}');
    }
  }
}
