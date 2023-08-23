import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safe_nails/common/app_colors.dart';
import 'package:safe_nails/common/common_strings.dart';
import 'package:safe_nails/common/injection_container.dart';
import 'package:safe_nails/common/text_styles.dart';
import 'package:safe_nails/ui/bloc/analysis/analysis_bloc.dart';
import 'package:safe_nails/ui/bloc/analysis/analysis_event.dart';
import 'package:safe_nails/ui/bloc/analysis/analysis_state.dart';

class Result extends StatefulWidget {
  bool? noWord;
  final XFile? photo;
  bool? isSafe;
  List<String>? unhealthyIngredientsFounded;

  Result(
      {this.isSafe,
      required this.photo,
      this.unhealthyIngredientsFounded,
      this.noWord});

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
            if (widget.noWord == true) {
              return Column(
                children: [
                  Container(
                    height: 350,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.file(
                        File(widget.photo!.path),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Text(
                      "Não foi possível identificar nenhum texto na imagem. Por favor, certifique-se de carregar uma imagem que contenha texto legível ou tente aproximar o texto para que fique nítido e possa ser lido com clareza.",
                      style: bodyDescription.copyWith(fontSize: 14.0),
                      textAlign: TextAlign.justify,
                    ),
                  )
                ],
              );
            }
            return Column(
              children: [
                Container(
                  height: 350,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.file(
                      File(widget.photo!.path),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Column(
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
                                "${widget.unhealthyIngredientsFounded?.length}/15",
                                style: bodyDescription.copyWith(
                                  color: AppColors.lightBlack,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
    );
  }

  Widget _valueResult({required bool? isSafe}) {
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
