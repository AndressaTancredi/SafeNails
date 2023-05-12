import 'package:safe_nails/ui/widgets/image_source.dart';

abstract class AnalysisEvent {}

class GetImageEvent extends AnalysisEvent {
  late ImageSource source;

  GetImageEvent({
    required this.source
});
}

// Events planning
// 1 - Get Image
// 2 - Processing Results
// 3 - Result Positive/Negative
