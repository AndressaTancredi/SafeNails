import 'package:safe_nails/data/ingredients_data.dart';

enum IngredientType {
  acetone,
  toluene,
  acetate,
  tolueno,
  formaldeido,
  dbp,
  resinaFormaldeido,
  canfora,
  xileno,
  etilTosilamida,
  tphp,
  parabenos,
  acetona,
  sulfatoNiquel,
  sulfatoCobalto,
  oleoMineral,
  gluten,
  animalOrigin,
}

extension Description on IngredientType {
  String get type {
    switch (this) {
      case IngredientType.acetone:
        return IngredientsData.toluenoDescription;
      case IngredientType.toluene:
        return IngredientsData.toluenoDescription;
      case IngredientType.acetate:
        return IngredientsData.toluenoDescription;
      case IngredientType.tolueno:
        return IngredientsData.toluenoDescription;
      case IngredientType.formaldeido:
        return IngredientsData.formaldeidoDescription;
      case IngredientType.dbp:
        return IngredientsData.dbpDescription;
      case IngredientType.resinaFormaldeido:
        return IngredientsData.resinaFormaldeidoDescription;
      case IngredientType.canfora:
        return IngredientsData.canforaDescription;
      case IngredientType.xileno:
        return IngredientsData.xilenoDescription;
      case IngredientType.etilTosilamida:
        return IngredientsData.etilTosilamidaDescription;
      case IngredientType.tphp:
        return IngredientsData.tphpDescription;
      case IngredientType.parabenos:
        return IngredientsData.parabenosDescription;
      case IngredientType.acetona:
        return IngredientsData.acetonaDescription;
      case IngredientType.sulfatoNiquel:
        return IngredientsData.sulfatoNiquelDescription;
      case IngredientType.sulfatoCobalto:
        return IngredientsData.sulfatoCobaltoDescription;
      case IngredientType.oleoMineral:
        return IngredientsData.oleoMineralDescription;
      case IngredientType.gluten:
        return IngredientsData.glutenDescription;
      case IngredientType.animalOrigin:
        return IngredientsData.derivadosAnimaisDescription;
    }
  }
}
