import 'package:flutter/material.dart';
import 'package:safe_nails/page/home_page.dart';
import 'common/app_router.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future main() async {
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
              home: const HomePage(),
            onGenerateRoute: _appRouter.onGeneratedRoute,
            navigatorKey: navigatorKey,
          );

  }
}


