import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:safe_nails/common/app_router.dart';
import 'package:safe_nails/page/old_home_page.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

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
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Nails',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: const OldHomePage(),
            onGenerateRoute: _appRouter.onGeneratedRoute,
            navigatorKey: navigatorKey,
          );

  }
}
