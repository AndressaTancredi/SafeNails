import 'package:bloc/bloc.dart';
import 'package:safe_nails/ui/bloc/analysis_event.dart';
import 'package:safe_nails/ui/bloc/analysis_state.dart';

class AnalysisBloc extends Bloc<AnalysisEvent, AnalysisState> {
  AnalysisBloc(super.initialState);

  // AnalysisBloc() : super() {
  //   on<CameraEvent>(_takePicture);
  // }

}
