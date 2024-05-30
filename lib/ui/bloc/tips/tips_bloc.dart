import 'package:bloc/bloc.dart';
import 'package:safe_nails/ui/bloc/tips/tips_event.dart';
import 'package:safe_nails/ui/bloc/tips/tips_state.dart';

class TipsBloc extends Bloc<TipsEvent, TipsState> {
  TipsBloc() : super(HydrationState()) {
    on<HydrationEvent>(_callHydrationState);
    on<CleansingEvent>(_callCleansingState);
    on<ProtectionEvent>(_callProtectionState);
  }

  void _callHydrationState(HydrationEvent event, Emitter<TipsState> emit) {
    emit(HydrationState());
  }

  void _callCleansingState(CleansingEvent event, Emitter<TipsState> emit) {
    emit(CleansingState());
  }

  void _callProtectionState(ProtectionEvent event, Emitter<TipsState> emit) {
    emit(ProtectionState());
  }
}
