import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'trigger_event.dart';
part 'trigger_state.dart';

class TriggerBloc extends Bloc<TriggerEvent, TriggerState> {
  TriggerBloc() : super(TriggerInit()) {
    on<TriggerAppEvent>((event, emit) {
      emit(TriggerAppState(
        event.key,
        event.type,
        additional: event.additional,
      ));
      // logApp('on<TriggerAppEvent> => emited');
    });
  }
}
