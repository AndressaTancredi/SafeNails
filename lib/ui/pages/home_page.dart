import 'package:flutter/material.dart';
import 'package:safe_nails/common/app_colors.dart';
import 'package:safe_nails/common/common_strings.dart';
import 'package:safe_nails/common/injection_container.dart';
import 'package:safe_nails/common/text_styles.dart';
import 'package:safe_nails/ui/widgets/image_source.dart';
import 'package:safe_nails/ui/widgets/loading.dart';

import '../widgets/result.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextStyle get title => sl<TextStyles>().pageTitle;
  TextStyle get subTitle => sl<TextStyles>().subTitle;
  TextStyle get bodyDescription => sl<TextStyles>().bodyDescription;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body:  Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: Column(
            children: [
              Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Result(positiveResult: false),
              ),
              // Padding(
              //   padding: EdgeInsets.symmetric(vertical: 16.0),
              //   child: const Loading(),
              // ),
          //     Column(
          //       crossAxisAlignment: CrossAxisAlignment.stretch,
          //       children: [
          //         Padding(
          //           padding: const EdgeInsets.only(top: 16.0),
          //           child: Container(
          //             padding: const EdgeInsets.all(14.0),
          //             decoration: BoxDecoration(
          //               color: Colors.white,
          //               borderRadius: BorderRadius.circular(16.0),
          //             ),
          //             child: Column(
          //               crossAxisAlignment: CrossAxisAlignment.start,
          //               children: [
          //                 Text(CommonStrings.stepOne, style: subTitle),
          //                 Padding(
          //                   padding: const EdgeInsets.only(top: 8.0, right: 4.0),
          //                   child: Text(CommonStrings.stepOneDescription, style: bodyDescription),
          //                 ),
          //                 const SizedBox(height: 8.0),
          //                 const Divider(thickness: 1, color: AppColors.grey,),
          //                 const SizedBox(height: 8.0),
          //                 Text(CommonStrings.stepTwo, style: subTitle),
          //                 Padding(
          //                   padding: const EdgeInsets.only(top: 8.0, right: 4.0),
          //                   child: Text(CommonStrings.stepTwoDescription, style: bodyDescription),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.only(top: 20.0, bottom: 16.0),
          //           child: Text(
          //               CommonStrings.choose,
          //               style: title),
          //         ),
          //         ImageSource(title: CommonStrings.camera, iconPath: 'assets/icons/camera.svg'),
          //         const SizedBox(height: 12.0),
          //         ImageSource(title: CommonStrings.gallery, iconPath: 'assets/icons/gallery.svg')
          //       ],
          //     ),
            ],
          ),
        ),
      ),
    );
  }
}
