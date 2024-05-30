import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safe_nails/common/app_colors.dart';
import 'package:safe_nails/common/capitalize.dart';
import 'package:safe_nails/common/common_strings.dart';
import 'package:safe_nails/common/injection_container.dart';
import 'package:safe_nails/common/text_styles.dart';
import 'package:safe_nails/data/ingredients_data.dart';
import 'package:safe_nails/data/ingredients_type.dart';
import 'package:safe_nails/ui/bloc/analysis/analysis_bloc.dart';
import 'package:safe_nails/ui/bloc/analysis/analysis_event.dart';
import 'package:safe_nails/ui/bloc/analysis/analysis_state.dart';
import 'package:safe_nails/ui/widgets/customPainter.dart';

class Result extends StatefulWidget {
  final bool? noWord;
  final XFile? photo;
  final bool? isSafe;
  final List<String> unhealthyIngredientsFounded;

  Result({
    this.isSafe,
    required this.photo,
    required this.unhealthyIngredientsFounded,
    this.noWord,
  });

  @override
  State<Result> createState() => _ResultState();
}

class _ResultState extends State<Result> with SingleTickerProviderStateMixin {
  final analysisBloc = sl<AnalysisBloc>();
  late List<String> ingredientDescriptionList;

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
    ingredientDescriptionList =
        _getIngredientDescriptionList(widget.unhealthyIngredientsFounded);
  }

  _toggleContainer() {
    if (_animation.status != AnimationStatus.completed) {
      _controller.forward();
    } else {
      _controller.animateBack(0, duration: Duration(seconds: 1));
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (popDisposition) async {
        analysisBloc.add(ClearResultEvent());
        return Future.value();
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
                    const SizedBox(height: 35.0),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        CommonStrings.imageTextNofFound,
                        style: bodyDescription.copyWith(fontSize: 14.0),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                );
              }

              if (widget.unhealthyIngredientsFounded.isEmpty) {
                return Container(
                  padding: const EdgeInsets.all(16.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'No ingredients found',
                    style: bodyDescription.copyWith(fontSize: 14.0),
                    textAlign: TextAlign.justify,
                  ),
                );
              }

              return Column(
                children: [
                  const SizedBox(height: 26.0),
                  GestureDetector(
                    onTap: _toggleContainer,
                    child: Container(
                      padding: const EdgeInsets.all(14.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                      ),
                      child: _valueResult(isSafe: widget.isSafe),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: Column(
                      children: [
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: widget.unhealthyIngredientsFounded.length,
                          itemBuilder: (context, index) {
                            if (index < ingredientDescriptionList.length) {
                              return Column(
                                children: [
                                  const SizedBox(height: 14),
                                  Container(
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
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
                                                  Capitalize().firstWord(widget
                                                          .unhealthyIngredientsFounded[
                                                      index]),
                                                  style: bodyDescription
                                                      .copyWith(fontSize: 16.0),
                                                  textAlign: TextAlign.justify,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            _getIngredientDescription(widget
                                                    .unhealthyIngredientsFounded[
                                                index]),
                                            style: bodyDescription.copyWith(
                                                fontSize: 14.0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              return SizedBox.shrink();
                            }
                          },
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Divider(height: 20),
                        ),
                        Text(
                          key: key1,
                          CommonStrings.source,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 11,
                            color: AppColors.softGrey.withOpacity(0.3),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
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
              const SizedBox(height: 14),
            ],
          ),
      ],
    );
  }

  List<String> _getIngredientDescriptionList(
      List<String> unhealthyIngredientsFounded) {
    final List<String> ingredientDescriptionList = [];
    for (final ingredient in unhealthyIngredientsFounded) {
      for (final element in IngredientType.values) {
        if (element.name.toUpperCase() == ingredient.toUpperCase()) {
          ingredientDescriptionList.add(element.type);
        }
      }
    }

    while (
        ingredientDescriptionList.length < unhealthyIngredientsFounded.length) {
      ingredientDescriptionList.add('');
    }
    return ingredientDescriptionList;
  }

  String _getIngredientDescription(String ingredient) {
    switch (ingredient.toUpperCase()) {
      case "TOLUENO":
      case "TOLUENE":
        return IngredientsData.toluenoDescription;
      case "ACETONA":
      case "ACETONE":
        return IngredientsData.acetonaDescription;
      case "PARABENOS":
      case "PARABENS":
        return IngredientsData.parabenosDescription;
      case "CÂNFORA":
      case "CAMPHOR":
        return IngredientsData.canforaDescription;
      case "XILENO":
      case "XYLENE":
        return IngredientsData.xilenoDescription;
      case "FORMALDEÍDO":
      case "FORMALDEHYDE":
        return IngredientsData.formaldeidoDescription;
      case "DIBUTILFTALATO (DBP)":
      case "DIBUTYL PHTHALATE (DBP)":
        return IngredientsData.dbpDescription;
      case "RESINA DE FORMALDEÍDO":
      case "FORMALDEHYDE RESIN":
        return IngredientsData.resinaFormaldeidoDescription;
      case "ETIL TOSILAMIDA":
      case "ETHYL TOSYLAMIDE":
        return IngredientsData.etilTosilamidaDescription;
      case "TRIFENILFOSFATO (TPHP)":
      case "TRIPHENYL PHOSPHATE (TPHP)":
        return IngredientsData.tphpDescription;
      case "SULFATO DE NÍQUEL":
      case "NICKEL SULFATE":
        return IngredientsData.sulfatoNiquelDescription;
      case "SULFATO DE COBALTO":
      case "COBALT SULFATE":
        return IngredientsData.sulfatoCobaltoDescription;
      case "ÓLEO MINERAL":
      case "MINERAL OIL":
        return IngredientsData.oleoMineralDescription;
      case "GLÚTEN":
      case "GLUTEN":
        return IngredientsData.glutenDescription;
      case "PRODUTOS DERIVADOS DE ANIMAIS":
      case "ANIMAL-DERIVED PRODUCTS":
        return IngredientsData.derivadosAnimaisDescription;
      default:
        return "DESCRIÇÃO NÃO DISPONÍVEL.";
    }
  }
}
