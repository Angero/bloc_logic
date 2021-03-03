part of 'radio_logic.dart';

class RadioBloc<S, V, F> extends Bloc<RadioEvent, RadioState> {
  RadioBloc() : super(SelectedRadioState(0));

  @override
  Stream<RadioState> mapEventToState(RadioEvent event) async* {
    if (event is SelectRadioEvent) {
      try {
        yield SelectedRadioState(event.index);
      } catch (e, stacktrace) {
        print(
            'BLOC_LOGIC: ${e.toString()} STACKTRACE: ${stacktrace.toString()}');
        yield FailureRadioState(e.toString()); //todo:
      }
    }
  }
}
