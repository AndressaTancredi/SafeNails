import 'package:flutter/material.dart';
import 'package:safe_nails/ui/pages/home_menu.dart';
import 'package:safe_nails/ui/pages/home_page.dart';
import 'package:safe_nails/ui/pages/login_page.dart';
import 'package:safe_nails/ui/pages/profile_page.dart';
import 'package:safe_nails/ui/pages/reset_password_page.dart';
import 'package:safe_nails/ui/pages/signup_page.dart';
import 'package:safe_nails/ui/pages/welcome_page.dart';

class AppRouter {
  Route onGeneratedRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/welcome_page':
        return MaterialPageRoute(builder: (_) => const WelcomePage());
      case '/login_page':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/signup_page':
        return MaterialPageRoute(builder: (_) => SignUpPage());
      case '/reset_password_page':
        return MaterialPageRoute(builder: (_) => ResetPasswordPage());
      case '/home_screen_page':
        return MaterialPageRoute(builder: (_) => HomeMenu());
      case '/profile_page':
        return MaterialPageRoute(builder: (_) => ProfilePage());
      case '/home_page':
        return MaterialPageRoute(builder: (_) => const HomePage());
      default:
        throw ArgumentError('Inexistent route: s${routeSettings.name}');
    }
  }
}
