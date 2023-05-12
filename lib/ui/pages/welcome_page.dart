import 'package:flutter/material.dart';
import 'package:safe_nails/common/common_strings.dart';
import 'package:safe_nails/common/injection_container.dart';
import 'package:safe_nails/common/text_styles.dart';

import '../widgets/button.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  TextStyle get title => sl<TextStyles>().principalTitle;
  TextStyle get subtitle => sl<TextStyles>().principalSubTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/nail_polish.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 84.0, bottom: 20.0 ),
                child: Text(CommonStrings.welcomeTitle,
                  style: title,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36.0),
                child: Text(CommonStrings.welcomeSubtitle,
                  style: subtitle,
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 44.0),
                  child: Button(buttonText:CommonStrings.getStarted, routePath: '/home_page'),

                  // ElevatedButton(
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: Colors.white,
                  //     elevation: 0,
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(10.0)),
                  //       minimumSize: const Size(180, 45),
                  //   ),
                  //   onPressed: () => Navigator.of(context).pushNamed('/home_page'),
                  //   child: Text(CommonStrings.getStarted,
                  //     style: button,
                  //   ),
                  // ),
                ),
              ),
            ],
          ),
        ],
      )
    );
  }
}
