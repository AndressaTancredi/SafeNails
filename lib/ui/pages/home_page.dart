import 'package:flutter/material.dart';
import 'package:safe_nails/common/app_colors.dart';
import 'package:safe_nails/common/common_strings.dart';
import 'package:safe_nails/common/injection_container.dart';
import 'package:safe_nails/common/text_styles.dart';
import 'package:safe_nails/ui/widgets/image_source.dart';

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
      backgroundColor: AppColors.background,
      body:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 44.0, bottom: 20.0),
              child: Text(
                CommonStrings.howToTitle,
                style: titlePageStyle),
            ),
            Container(
              padding: const EdgeInsets.all(16.0 ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(CommonStrings.stepOne),
                  const SizedBox(height: 12.0),
                  Text(CommonStrings.stepOneDescription),
                  const SizedBox(height: 8.0),
                  const Divider(thickness: 0.8, color: Colors.black38,),
                  const SizedBox(height: 8.0),
                  Text(CommonStrings.stepTwo),
                  const SizedBox(height: 12.0),
                  Text(CommonStrings.stepTwoDescription),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 16.0),
              child: Text(
                  CommonStrings.choose,
                  style: titlePageStyle.copyWith(fontSize: 20.0)),
            ),
            ImageSource(title: CommonStrings.camera, icon: Icons.camera_alt_outlined),
            const SizedBox(height: 12.0),
            ImageSource(title: CommonStrings.gallery, icon: Icons.image_outlined)
          ],
        ),
      ),
    );
  }
}
