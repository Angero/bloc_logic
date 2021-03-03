part of 'check_logic.dart';

class CheckBloc extends Bloc<CheckEvent, CheckState> {

  CheckBloc() : super(UncheckedCheckState());

  @override
  Stream<CheckState> mapEventToState(CheckEvent event) async* {
    if (event is CheckCheckEvent)
      yield CheckedCheckState();
    else if (event is UncheckCheckEvent) {
      yield UncheckedCheckState();
    }
  }
}
