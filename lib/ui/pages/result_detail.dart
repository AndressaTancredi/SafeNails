import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final Map<String, dynamic> unhealthyIngredientsFounded2;
  final Map<String, List<String>> photo;

  const ResultDetail(
      {super.key,
      required this.unhealthyIngredientsFounded2,
      required this.photo});

  @override
  State<ResultDetail> createState() => _ResultDetailState();
}

class _ResultDetailState extends State<ResultDetail> {
  final analysisBloc = sl<AnalysisBloc>();

  TextStyle get title => sl<TextStyles>().pageTitle;
  TextStyle get bodyDescription => sl<TextStyles>().bodyDescription;

  @override
  Widget build(BuildContext context) {
    List<String> unhealthyIngredientsFounded = [];
    widget.unhealthyIngredientsFounded2
        .forEach((key, value) => unhealthyIngredientsFounded = value);

    unhealthyIngredientsFounded.toList();

    String photoPath = "";

    widget.photo.forEach((key, value) {
      photoPath = value.first;
    });

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
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(14.0),
                  height: 350,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.0)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.file(
                      File(photoPath),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                _met(unhealthyIngredientsFounded),
                BlocBuilder<AnalysisBloc, AnalysisState>(
                  bloc: analysisBloc,
                  builder: (context, state) {
                    if (state is ResultState) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 22.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(CommonStrings.badIngredientsFounded,
                                    style: title.copyWith(fontSize: 20.0)),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: unhealthyIngredientsFounded.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Icon(
                                              Icons.arrow_circle_right_outlined,
                                              color: AppColors.pink,
                                              size: 20.0,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                unhealthyIngredientsFounded[
                                                    index],
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
                                              _metodo(unhealthyIngredientsFounded)[
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
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 22.0, vertical: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(CommonStrings.badIngredientsNotFound,
                                    style: title.copyWith(fontSize: 20.0)),
                                const SizedBox(
                                  height: 16.0,
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: (_badIngredientsNotFound(
                                          unhealthyIngredientsFounded))
                                      .length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 4.0),
                                      child: Container(
                                        padding: const EdgeInsets.all(4.0),
                                        // height: 400,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.adjust_rounded,
                                              color: AppColors.pink,
                                              size: 20.0,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4.0),
                                              child: Text(
                                                _badIngredientsNotFound(
                                                        unhealthyIngredientsFounded)[
                                                    index],
                                                style: bodyDescription.copyWith(
                                                    fontSize: 12.0),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
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
    );
  }

  Widget _met(List<String> unhealthyIngredientsFounded) {
    if (unhealthyIngredientsFounded.isEmpty) {
      return Text(CommonStrings.badIngredientsFounded,
          style: title.copyWith(fontSize: 20.0));
    } else {
      return const SizedBox.shrink();
    }
  }

  List<String> _badIngredientsNotFound(
      List<String> unhealthyIngredientsFounded) {
    if (unhealthyIngredientsFounded.isEmpty) {
      return IngredientsData.unhealthyIngredients;
    } else {
      final mergedList = IngredientsData.unhealthyIngredients;
      unhealthyIngredientsFounded
          .where((element) =>
              !IngredientsData.unhealthyIngredients.contains(element))
          .toList();
      return mergedList;
    }
  }

  List<String> _metodo(List<String> unhealthyIngredientsFounded) {
    final List<String> descriptionList = [];
    for (final ingre in unhealthyIngredientsFounded) {
      IngredientType.values.forEach((element) {
        if (element.name.toUpperCase() == ingre) {
          descriptionList.add(element.type);
        }
      });
    }
    return descriptionList;
  }
}
