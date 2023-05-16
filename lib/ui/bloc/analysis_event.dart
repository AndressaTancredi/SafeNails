abstract class AnalysisEvent {}

class NewImageEvent extends AnalysisEvent {
  final bool cameraSource;
  NewImageEvent({required this.cameraSource});
}

class ClearResultEvent extends AnalysisEvent {}

class DetailResultEvent extends AnalysisEvent {
  late final List<String> unhealthyIngredientsFounded;
  DetailResultEvent({required this.unhealthyIngredientsFounded});
}
