import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';

class Analytics {
  void onScreenView(String screenName, {bool applyTag = true}) {
    final String analyticsScreenName;
    if (applyTag) {
      analyticsScreenName = _buildTag(screenName);
    } else {
      analyticsScreenName = screenName;
    }
    FirebaseAnalytics.instance.logScreenView(screenName: analyticsScreenName);
  }

  void onCustomEvent(String name,
      {Map<String, dynamic>? parameters, bool applyTag = true}) {
    final String analyticsName;
    if (applyTag) {
      analyticsName = _buildTag(name);
    } else {
      analyticsName = name;
    }
    FirebaseAnalytics.instance
        .logEvent(name: analyticsName, parameters: parameters);
  }

  String _buildTag(String tag) {
    if (Platform.isAndroid) {
      return '${tag}_android';
    } else if (Platform.isIOS) {
      return '${tag}_ios';
    }

    return tag;
  }
}

class AnalyticsEventTags {
  // Pages
  static const home_page = 'home_page';
  static const login_page = 'login_page';
  static const profile_page = 'profile_page';
  static const reset_pass_page = 'reset_pass_page';
  static const signup_page = 'signup_page';
  static const terms_and_conditions_page = 'terms_and_conditions_page';
  static const tips_page = 'tips_page';
  static const welcome_page = 'welcome_page';

  //Action Buttons
  static const camera_scan = 'camera_scan';
  static const gallery_scan = 'gallery_scan';
}
