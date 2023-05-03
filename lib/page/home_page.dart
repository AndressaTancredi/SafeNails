import 'package:flutter/material.dart';
import 'package:safe_nails/common/common_strings.dart';
import 'package:safe_nails/common/injection_container.dart';
import 'package:safe_nails/common/text_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextStyle get titlePageStyle => sl<TextStyles>().pageTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(CommonStrings.howToTitle),
          ),
        ),
      ),
    );
  }
}
