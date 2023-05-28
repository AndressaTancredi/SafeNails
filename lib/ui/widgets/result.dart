import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safe_nails/common/app_colors.dart';
import 'package:safe_nails/common/common_strings.dart';
import 'package:safe_nails/common/injection_container.dart';
import 'package:safe_nails/common/text_styles.dart';
import 'package:safe_nails/ui/bloc/analysis_bloc.dart';
import 'package:safe_nails/ui/bloc/analysis_event.dart';
import 'package:safe_nails/ui/bloc/analysis_state.dart';

class Result extends StatefulWidget {
  final XFile? photo;
  final bool isSafe;
  final List<String> unhealthyIngredientsFounded;

  const Result(
      {required this.isSafe,
      required this.photo,
      required this.unhealthyIngredientsFounded});

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> {
  final analysisBloc = sl<AnalysisBloc>();

  TextStyle get title => sl<TextStyles>().pageTitle;
  TextStyle get bodyDescription => sl<TextStyles>().bodyDescription;
  TextStyle get button => sl<TextStyles>().buttonText;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        analysisBloc.add(ClearResultEvent());
        return true;
      },
      child: BlocBuilder<AnalysisBloc, AnalysisState>(
          bloc: analysisBloc,
          builder: (context, state) {
            return Column(
              children: [
                Container(
                  height: 300,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.file(
                      File(widget.photo!.path),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(14.0),
                      height: 100,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.0)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(CommonStrings.result, style: title),
                                GestureDetector(
                                  onTap: () => Navigator.pushNamed(
                                      context, '/result_detail',
                                      arguments: {
                                        "unhealthyIngredientsFounded":
                                            widget.unhealthyIngredientsFounded,
                                        "photoPath": widget.photo!.path
                                      }),
                                  child: Text(CommonStrings.seeMore,
                                      style: bodyDescription.copyWith(
                                        color: AppColors.lightBlack,
                                        decoration: TextDecoration.underline,
                                      )),
                                )
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _valueResult(isSafe: widget.isSafe),
                              Text(
                                "${widget.unhealthyIngredientsFounded.length}/15",
                                style: bodyDescription.copyWith(
                                  color: AppColors.lightBlack,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          minimumSize: const Size(180, 45),
                        ),
                        onPressed: () => analysisBloc.add(ClearResultEvent()),
                        child: Text(
                          CommonStrings.restarted,
                          style: button,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            );
          }),
    );
  }

  Widget _valueResult({required bool isSafe}) {
    String iconPath;
    Color? textColor;
    String messageResult;

    if (isSafe == true) {
      iconPath = "assets/icons/tick_circle.svg";
      textColor = AppColors.green;
      messageResult = CommonStrings.safeResult;
    } else {
      iconPath = "assets/icons/close_circle.svg";
      textColor = AppColors.red;
      messageResult = CommonStrings.notSafeResult;
    }

    return Row(
      children: [
        SvgPicture.asset(iconPath),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            messageResult,
            style: bodyDescription.copyWith(color: textColor),
          ),
        ),
      ],
    );
  }
}
