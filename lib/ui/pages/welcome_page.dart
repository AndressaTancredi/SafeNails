import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safe_nails/common/analytics.dart';
import 'package:safe_nails/common/common_strings.dart';
import 'package:safe_nails/common/injection_container.dart';
import 'package:safe_nails/common/text_styles.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  TextStyle get button => sl<TextStyles>().buttonText;
  TextStyle get title => sl<TextStyles>().principalTitle;
  TextStyle get subtitle =>
      sl<TextStyles>().principalSubTitle.copyWith(fontSize: 19.0);

  @override
  void initState() {
    super.initState();
    sl<Analytics>().onScreenView(AnalyticsEventTags.welcome_page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/nail_polish.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 34.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 100.0, bottom: 50.0),
                  child: Text(
                    CommonStrings.welcomeTitle,
                    style: title,
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  CommonStrings.welcomeSubtitle,
                  style: subtitle,
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  child: Container(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.9),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                      ),
                      onPressed: () {
                        _checkUserAndNavigate(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          CommonStrings.getStarted,
                          style: button,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _checkUserAndNavigate(context) async {
    await FirebaseAuth.instance.idTokenChanges().listen(
      (User? user) {
        if (user?.email != null) {
          Navigator.of(context).pushNamed('/home_screen_page');
        } else {
          Navigator.of(context).pushNamed('/login_page');
        }
      },
    );
  }
}
