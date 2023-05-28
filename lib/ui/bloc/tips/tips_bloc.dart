import 'package:bloc/bloc.dart';
import 'package:safe_nails/ui/bloc/tips/tips_event.dart';
import 'package:safe_nails/ui/bloc/tips/tips_state.dart';

class TipsBloc extends Bloc<TipsEvent, TipsState> {
  TipsBloc() : super(HydrationState()) {
    on<CleansingEvent>(_callCleansingState);
  }

  void _callCleansingState(CleansingEvent event, Emitter emit) {
    emit(CleansingState());
  }
}
