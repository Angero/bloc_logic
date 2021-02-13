import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_logic/common/core/usecases/use_case_interface.dart';
import 'package:meta/meta.dart';

part 'check_event.dart';

part 'check_state.dart';

class CheckBloc extends Bloc<CheckEvent, CheckState> {

  CheckBloc() : super(OffCheckState());

  @override
  Stream<CheckState> mapEventToState(CheckEvent event) async* {
    if (event is TurnOnCheckEvent)
      yield OnCheckState();
    else if (event is TurnOffCheckEvent) {
      yield OffCheckState();
    }
  }
}
