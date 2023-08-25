import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safe_nails/common/app_colors.dart';
import 'package:safe_nails/common/common_strings.dart';
import 'package:safe_nails/common/injection_container.dart';
import 'package:safe_nails/common/text_styles.dart';
import 'package:safe_nails/ui/bloc/analysis/analysis_bloc.dart';
import 'package:safe_nails/ui/bloc/analysis/analysis_event.dart';
import 'package:safe_nails/ui/bloc/analysis/analysis_state.dart';
import 'package:safe_nails/ui/widgets/banner_ad.dart';
import 'package:safe_nails/ui/widgets/image_source.dart';
import 'package:safe_nails/ui/widgets/loading.dart';
import 'package:safe_nails/ui/widgets/result.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final analysisBloc = sl<AnalysisBloc>();

  TextStyle get title => sl<TextStyles>().pageTitle;
  TextStyle get subTitle => sl<TextStyles>().subTitle;
  TextStyle get bodyDescription => sl<TextStyles>().bodyDescription;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        analysisBloc.add(ClearResultEvent());
        return true;
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.0),
            child: SafeArea(
              child: Column(
                children: [
                  BlocBuilder<AnalysisBloc, AnalysisState>(
                    bloc: analysisBloc,
                    builder: (context, state) {
                      if (state is AnalysisLoadingState) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: Loading(),
                        );
                      }
                      if (state is ResultState) {
                        final photo = state.photo;
                        final isSafe = state.isSafe;
                        final unhealthyIngredientsFounded =
                            state.unhealthyIngredientsFounded;
                        return Padding(
                          padding: const EdgeInsets.only(top: 44.0),
                          child: Column(
                            children: [
                              Result(
                                isSafe: isSafe,
                                photo: photo,
                                unhealthyIngredientsFounded:
                                    unhealthyIngredientsFounded,
                              ),
                            ],
                          ),
                        );
                      }
                      if (state is NoWordState) {
                        final photo = state.photo;
                        final noWord = state.noWord;
                        return Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Result(
                            noWord: noWord,
                            photo: photo,
                          ),
                        );
                      }
                      if (state is AnalysisEmptyState) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child:
                                  Text("Como usar o Safe Nails", style: title),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Container(
                                padding: const EdgeInsets.all(14.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(CommonStrings.stepOne,
                                        style: subTitle),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, right: 4.0),
                                      child: Text(
                                          CommonStrings.stepOneDescription,
                                          style: bodyDescription),
                                    ),
                                    const SizedBox(height: 8.0),
                                    const Divider(
                                      thickness: 1,
                                      color: AppColors.grey,
                                    ),
                                    const SizedBox(height: 8.0),
                                    Text(CommonStrings.stepTwo,
                                        style: subTitle),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 8.0, right: 4.0),
                                      child: Text(
                                          CommonStrings.stepTwoDescription,
                                          style: bodyDescription),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text("Escolha:", style: title),
                            ),
                            Row(
                              children: [
                                Container(
                                  child: Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        analysisBloc.add(
                                            NewImageEvent(cameraSource: true));
                                      },
                                      child: ImageSource(
                                          title: CommonStrings.camera,
                                          iconPath: 'assets/icons/camera.svg'),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 25),
                                Container(
                                  child: Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        analysisBloc.add(
                                            NewImageEvent(cameraSource: false));
                                      },
                                      child: ImageSource(
                                          title: CommonStrings.gallery,
                                          iconPath: 'assets/icons/gallery.svg'),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: BannerAdmob(idAdMob: bannerId),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  final String bannerId = Platform.isAndroid
      ? 'ca-app-pub-6850065566204568/5619356631'
      : 'ca-app-pub-6850065566204568/1634804509';
}
