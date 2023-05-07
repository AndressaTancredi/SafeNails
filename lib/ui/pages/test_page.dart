import 'package:flutter/material.dart';
import 'package:safe_nails/common/app_colors.dart';
import 'package:safe_nails/common/injection_container.dart';
import 'package:safe_nails/common/text_styles.dart';

class TestePage extends StatefulWidget {
  const TestePage({super.key});

  @override
  State<TestePage> createState() => _TestePageState();
}

class _TestePageState extends State<TestePage> {
  TextStyle get titlePageStyle => sl<TextStyles>().pageTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        // leading: IconButton(
        //   icon: const Icon(
        //     Icons.arrow_back_sharp,
        //     color: Colors.black54,
        //     size: 20,),
        //   onPressed: () => Navigator.of(context).pop(),
        // ),
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text("TESTANDO", style: titlePageStyle,),
          ),
        ),
      ),
      body: const ColoredBox(
        color: Colors.purple,
      ),
    );
  }
}
