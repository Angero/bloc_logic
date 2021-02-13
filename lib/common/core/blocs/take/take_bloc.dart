import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_logic/common/core/usecases/use_case_interface.dart';
import 'package:bloc_logic/common/data/result.dart';
import 'package:meta/meta.dart';

part 'take_event.dart';

part 'take_state.dart';

class TakeBloc<S, V, F> extends Bloc<TakeEvent, TakeState> {
  final IFutureUseCase<S, V, F> usecase;

  TakeBloc({@required this.usecase}) : super(InitialTakeState());

  @override
  Stream<TakeState> mapEventToState(TakeEvent event) async* {
    if (event is SendTakeEvent) {
      yield WaitingTakeState();
      try {
        Result<S, F> result = await usecase.execute(event.value);
        if (!result.hasFailure())
          yield SuccessTakeState<S>(result.success);
        else
          yield FailureTakeState<F>(result.failure);
      } catch (e, stacktrace) {
        print('RA: ${e.toString()} STACKTRACE: ${stacktrace.toString()}');
        yield FailureTakeState(e.toString()); //todo:
      }
    } else if (event is InitiateTakeEvent) {
      yield InitialTakeState();
    }
  }
}
