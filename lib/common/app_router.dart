import 'package:flutter/material.dart';
import 'package:safe_nails/ui/pages/home_page.dart';
import 'package:safe_nails/ui/pages/result_detail.dart';
import 'package:safe_nails/ui/pages/welcome_page.dart';

import '../ui/pages/home_screen_page.dart';

class AppRouter {
  Route onGeneratedRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/welcome_page':
        return MaterialPageRoute(builder: (_) => const WelcomePage());
      case '/home_screen_page':
        return MaterialPageRoute(builder: (_) => HomeScreenPage());
      case '/home_page':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/result_detail':
        final List<String> unhealthyIngredientsFounded =
            (routeSettings.arguments!
                    as Map<String, dynamic>)['unhealthyIngredientsFounded']
                as List<String>;
        final String photoPath = (routeSettings.arguments!
            as Map<String, dynamic>)['photoPath'] as String;
        return MaterialPageRoute(
            builder: (_) => ResultDetailPage(
                unhealthyIngredientsFounded: unhealthyIngredientsFounded,
                photoPath: photoPath));
      default:
        throw ArgumentError('Inexistent route: s${routeSettings.name}');
    }
  }
}
