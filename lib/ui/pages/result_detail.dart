import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:safe_nails/common/app_colors.dart';
import 'package:safe_nails/common/common_strings.dart';
import 'package:safe_nails/common/injection_container.dart';
import 'package:safe_nails/common/text_styles.dart';
import 'package:safe_nails/data/datasources/Ingredients_type.dart';
import 'package:safe_nails/data/datasources/ingredients_data.dart';
import 'package:safe_nails/ui/bloc/analysis_bloc.dart';
import 'package:safe_nails/ui/bloc/analysis_event.dart';
import 'package:safe_nails/ui/bloc/analysis_state.dart';

class ResultDetail extends StatefulWidget {
  final List<String> unhealthyIngredientsFounded;
  final String photoPath;

  const ResultDetail(
      {super.key,
      required this.unhealthyIngredientsFounded,
      required this.photoPath});

  @override
  State<ResultDetail> createState() => _ResultDetailState();
}

class _ResultDetailState extends State<ResultDetail> {
  final analysisBloc = sl<AnalysisBloc>();

  TextStyle get title => sl<TextStyles>().pageTitle;
  TextStyle get bodyDescription => sl<TextStyles>().bodyDescription;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        analysisBloc.add(ClearResultEvent());
        return true;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.background,
            title: Text(CommonStrings.resultDetailTitle, style: title),
            centerTitle: true,
            elevation: 0,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black54,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 22.0, vertical: 4),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(14.0),
                    height: 330,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.0)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.file(
                        File(widget.photoPath),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  _buildIngredientsWidget(widget.unhealthyIngredientsFounded),
                  BlocBuilder<AnalysisBloc, AnalysisState>(
                    bloc: analysisBloc,
                    builder: (context, state) {
                      if (state is ResultState) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 16.0,
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount:
                                      widget.unhealthyIngredientsFounded.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SvgPicture.asset(
                                              "assets/icons/close_circle.svg",
                                              color: AppColors.pink,
                                              height: 18,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, bottom: 4.0),
                                              child: Text(
                                                widget
                                                    .unhealthyIngredientsFounded[
                                                        index]
                                                    .toLowerCase(),
                                                style: bodyDescription.copyWith(
                                                    fontSize: 14.0),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(16.0),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            child: Text(
                                              _getIngredientDescriptionList(widget
                                                      .unhealthyIngredientsFounded)[
                                                  index],
                                              style: bodyDescription.copyWith(
                                                  fontSize: 14.0),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(CommonStrings.badIngredientsNotFound,
                                      style: title.copyWith(fontSize: 20.0)),
                                  const SizedBox(
                                    height: 16.0,
                                  ),
                                  SingleChildScrollView(
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: (_getRemainingBadIngredients(widget
                                                      .unhealthyIngredientsFounded)
                                                  .length /
                                              3)
                                          .ceil(),
                                      itemBuilder: (context, index) {
                                        final startIndex = index * 3;
                                        final endIndex = (startIndex + 3).clamp(
                                            0,
                                            _getRemainingBadIngredients(widget
                                                    .unhealthyIngredientsFounded)
                                                .length);
                                        final rowIngredients =
                                            _getRemainingBadIngredients(widget
                                                    .unhealthyIngredientsFounded)
                                                .sublist(startIndex, endIndex);

                                        return Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          child: Wrap(
                                            spacing: 4.0,
                                            runSpacing: 4.0,
                                            children: rowIngredients
                                                .map((ingredient) {
                                              return Container(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    const Icon(
                                                      Icons.adjust_rounded,
                                                      color: AppColors.pink,
                                                      size: 14.0,
                                                    ),
                                                    const SizedBox(width: 4.0),
                                                    Text(
                                                      ingredient,
                                                      style: bodyDescription
                                                          .copyWith(
                                                              fontSize: 12.0),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIngredientsWidget(List<String> unhealthyIngredientsFounded) {
    if (unhealthyIngredientsFounded.isNotEmpty) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "${widget.unhealthyIngredientsFounded.length}/15",
              style: bodyDescription.copyWith(
                color: AppColors.lightBlack,
              ),
            ),
          ),
          Text(CommonStrings.badIngredientsFounded,
              style: title.copyWith(fontSize: 20.0)),
        ],
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        child: Container(
            padding: const EdgeInsets.all(8.0),
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16.0)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Image.asset(
                    "assets/images/check.png",
                    fit: BoxFit.cover,
                  ),
                ),
                Center(
                    child: Text(
                  CommonStrings.congratulations,
                  style: title.copyWith(fontSize: 14.0),
                ))
              ],
            )),
      );
    }
  }

  List<String> _getRemainingBadIngredients(
      List<String> unhealthyIngredientsFounded) {
    if (unhealthyIngredientsFounded.isEmpty) {
      return IngredientsData.unhealthyIngredients;
    } else {
      final remainingBadIngredients = IngredientsData.unhealthyIngredients;

      unhealthyIngredientsFounded.forEach((element) {
        if (IngredientsData.unhealthyIngredients.contains(element)) {
          remainingBadIngredients.remove(element);
        }
      });
      return remainingBadIngredients;
    }
  }

  List<String> _getIngredientDescriptionList(
      List<String> unhealthyIngredientsFounded) {
    final List<String> ingredientDescriptionList = [];
    for (final ingredient in unhealthyIngredientsFounded) {
      IngredientType.values.forEach((element) {
        if (element.name.toUpperCase() == ingredient.toUpperCase()) {
          ingredientDescriptionList.add(element.type);
        }
      });
    }
    return ingredientDescriptionList;
  }
}
