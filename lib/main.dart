import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:safe_nails/common/app_router.dart';
import 'package:safe_nails/common/injection_container.dart' as get_it;
import 'package:safe_nails/firebase_options.dart';
import 'package:safe_nails/ui/pages/welcome_page.dart';
import 'package:safe_nails/web/ui/landing_page.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await dotenv.load(fileName: "assets/.env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await get_it.init();
  MobileAds.instance.initialize();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppRouter _appRouter = AppRouter();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage('assets/images/nail_polish.jpg'), context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Safe Nails',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: kIsWeb ? const LandingPage() : const WelcomePage(),
      onGenerateRoute: _appRouter.onGeneratedRoute,
      navigatorKey: navigatorKey,
    );
  }
}
