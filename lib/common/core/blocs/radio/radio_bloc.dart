import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'radio_event.dart';

part 'radio_state.dart';

class RadioBloc<S, V, F> extends Bloc<RadioEvent, RadioState> {
  RadioBloc() : super(SwitchedRadioState(0));

  @override
  Stream<RadioState> mapEventToState(RadioEvent event) async* {
    if (event is SwitchRadioEvent) {
      try {
        yield SwitchedRadioState(event.index);
      } catch (e, stacktrace) {
        print(
            'BLOC_LOGIC: ${e.toString()} STACKTRACE: ${stacktrace.toString()}');
        yield FailureRadioState(e.toString()); //todo:
      }
    }
  }
}
