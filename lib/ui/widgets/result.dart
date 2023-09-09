import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safe_nails/common/app_colors.dart';
import 'package:safe_nails/common/capitalize.dart';
import 'package:safe_nails/common/common_strings.dart';
import 'package:safe_nails/common/injection_container.dart';
import 'package:safe_nails/common/text_styles.dart';
import 'package:safe_nails/data/datasources/Ingredients_type.dart';
import 'package:safe_nails/ui/bloc/analysis/analysis_bloc.dart';
import 'package:safe_nails/ui/bloc/analysis/analysis_event.dart';
import 'package:safe_nails/ui/bloc/analysis/analysis_state.dart';
import 'package:safe_nails/ui/widgets/customPainter.dart';

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

class _ResultState extends State<Result> with SingleTickerProviderStateMixin {
  final analysisBloc = sl<AnalysisBloc>();

  TextStyle get title => sl<TextStyles>().pageTitle;
  TextStyle get bodyDescription => sl<TextStyles>().bodyDescription;
  TextStyle get button => sl<TextStyles>().buttonText;

  late AnimationController _controller;
  late Animation<double> _animation;

  var key1 = GlobalKey();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }

  _toggleContainer() {
    print(_animation.status);
    if (_animation.status != AnimationStatus.completed) {
      _controller.forward();
    } else {
      _controller.animateBack(0, duration: Duration(seconds: 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    ScrollController _controller = ScrollController();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      _controller.jumpTo(_controller.position.maxScrollExtent);
    });
    return WillPopScope(
      onWillPop: () async {
        analysisBloc.add(ClearResultEvent());
        return true;
      },
      child: Column(
        children: [
          SizedBox(
            child: CustomPaint(
              painter: MyCustomPainter(frameSFactor: .2, padding: 2),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: ClipRRect(
                  child: Image.file(
                    File(widget.photo!.path),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            height: 400,
            width: double.infinity,
          ),
          BlocBuilder<AnalysisBloc, AnalysisState>(
            bloc: analysisBloc,
            builder: (context, state) {
              if (widget.noWord == true) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                  const SizedBox(height: 26.0),
                  GestureDetector(
                    onTap: () {
                      // Scrollable.ensureVisible(key1.currentContext!);

                      _toggleContainer();
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                      ),
                      child: _valueResult(isSafe: widget.isSafe),
                    ),
                  ),
                  SizeTransition(
                    sizeFactor: _animation,
                    axis: Axis.vertical,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 28.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8),
                        ),
                      ),
                      child: Column(
                        children: [
                          ListView.builder(
                            controller: _controller,
                            // physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                widget.unhealthyIngredientsFounded!.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  SizedBox(height: 14),
                                  Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                    ),
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      child: Column(
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
                                                  // key: key1,
                                                  Capitalize().firstWord(widget
                                                          .unhealthyIngredientsFounded![
                                                      index]),
                                                  style: bodyDescription
                                                      .copyWith(fontSize: 14.0),
                                                  textAlign: TextAlign.justify,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            _getIngredientDescriptionList(widget
                                                    .unhealthyIngredientsFounded!)[
                                                index],
                                            style: bodyDescription.copyWith(
                                                fontSize: 14.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Divider(height: 20),
                          ),
                          Text(
                            key: key1,
                            'Fonte: Environmental Working Group.',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 11,
                                color: AppColors.softGrey.withOpacity(0.3)),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _valueResult({required bool? isSafe}) {
    String imagePath;
    Color? textColor;
    String messageResult;

    if (isSafe == true) {
      imagePath = "assets/images/safeResult.png";
      textColor = AppColors.green;
      messageResult = CommonStrings.safeResult;
    } else {
      imagePath = "assets/images/notSafeResult.png";
      textColor = AppColors.pink;
      messageResult = CommonStrings.notSafeResult;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image(image: AssetImage(imagePath)),
        if (messageResult == CommonStrings.safeResult)
          Padding(
            padding: const EdgeInsets.only(left: 1.0),
            child: Text(
              messageResult.toUpperCase(),
              style: bodyDescription.copyWith(
                  color: textColor, fontSize: 14, height: 1.5),
              textAlign: TextAlign.center,
            ),
          ),
        if (messageResult == CommonStrings.notSafeResult)
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                messageResult.toUpperCase(),
                style: bodyDescription.copyWith(
                    color: textColor, fontSize: 14, height: 1.5),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 14),
              Row(
                children: [
                  Text(
                    'Saber mais',
                    style: bodyDescription.copyWith(
                        color: AppColors.softGrey,
                        decoration: TextDecoration.underline),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_sharp,
                    size: 20,
                    color: AppColors.softGrey,
                  ),
                ],
              ),
            ],
          ),
      ],
    );
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
