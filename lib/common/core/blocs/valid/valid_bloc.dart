import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_logic/common/core/usecases/use_case_interface.dart';
import 'package:bloc_logic/common/data/result.dart';
import 'package:meta/meta.dart';

part 'valid_event.dart';

part 'valid_state.dart';

class ValidBloc<S, V, F> extends Bloc<ValidEvent, ValidState> {
  final IUseCase<S, V, F> usecase;

  ValidBloc({@required this.usecase})
      : super(ChangedValidState(result: Result(success: null)));

  @override
  Stream<ValidState> mapEventToState(ValidEvent event) async* {
    if (event is ChangeValidEvent) {
      if (event.value == null)
        yield ChangedValidState(result: Result(success: null));
      else {
        Result<S, F> result = this.usecase.execute(event.value);
        yield ChangedValidState(result: result);
      }
    } else if (event is InitialValidEvent) {
      yield ChangedValidState(result: Result(success: null));
    }
  }
}
