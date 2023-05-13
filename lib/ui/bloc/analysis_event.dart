abstract class AnalysisEvent {}

class NewImageEvent extends AnalysisEvent {
  final bool cameraSource;
  NewImageEvent({required this.cameraSource});
}

class ClearResultEvent extends AnalysisEvent {}
