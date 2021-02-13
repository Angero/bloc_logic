import 'package:bloc_logic/common/core/blocs/take/take_bloc.dart';
import 'package:bloc_logic/common/core/usecases/use_case_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TakeLogic<S, V, F> {
  TakeBloc<S, V, F> _takeBloc;

  TakeBloc get takeBloc => _takeBloc;

  TakeLogic({@required IFutureUseCase<S, V, F> usecase}) {
    _takeBloc = TakeBloc<S, V, F>(usecase: usecase);
  }

  void request([V value]) {
    _takeBloc.add(SendTakeEvent(value));
  }

  Widget builder({
    Function() initial,
    Function(SuccessTakeState<S>) success,
    Function(FailureTakeState<F>) failure,
    Function() waiting,
    Function() unknown,
  }) {
    return BlocBuilder<TakeBloc, TakeState>(
        cubit: _takeBloc,
        builder: (BuildContext context, TakeState takeState) {
          if (takeState is InitialTakeState)
            return initial();
          else if (takeState is SuccessTakeState<S>)
            return success(takeState);
          else if (takeState is FailureTakeState<F>)
            return failure(takeState);
          else if (takeState is WaitingTakeState)
            return waiting();
          else
            return unknown();
        });
  }

  void dispose() {
    _takeBloc.close();
  }
}
