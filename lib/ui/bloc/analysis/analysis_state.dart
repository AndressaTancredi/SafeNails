import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

abstract class AnalysisState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AnalysisEmptyState extends AnalysisState {}

class AnalysisLoadingState extends AnalysisState {}

class ResultState extends AnalysisState {
  late final XFile? photo;
  late final bool isSafe;
  late final List<String> unhealthyIngredientsFounded;

  ResultState(
      {required this.photo,
      required this.isSafe,
      required this.unhealthyIngredientsFounded});
}

class NoWordState extends AnalysisState {
  late final bool? noWord;
  late final XFile? photo;
  NoWordState({required this.photo, required this.noWord});
}
