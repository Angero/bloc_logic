import 'package:bloc_logic/common/core/blocs/take/take_bloc.dart';
import 'package:bloc_logic/common/core/usecases/use_case_interface.dart';
import 'package:bloc_logic/common/view/message_container.dart';
import 'package:bloc_logic/common/view/waiting_container.dart';
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

  void dispose() {
    _takeBloc.close();
  }

  BlocBuilder builder({
    Function() initial,
    Function(SuccessTakeState<S>) success,
    Function(FailureTakeState<F>) failure,
    Function() waiting,
    Function() usual,
  }) {
    return BlocBuilder<TakeBloc, TakeState>(
      cubit: _takeBloc,
      builder: (BuildContext context, TakeState takeState) {
        if (takeState is InitialTakeState)
          return initial == null
              ? MessageContainer(message: 'Initial')
              : initial();
        else if (takeState is SuccessTakeState<S>)
          return success == null
              ? MessageContainer(message: 'Success')
              : success(takeState);
        else if (takeState is FailureTakeState<F>)
          return failure == null
              ? MessageContainer(message: 'Failure')
              : failure(takeState);
        else if (takeState is WaitingTakeState)
          return waiting == null ? WaitingContainer() : waiting();
        return usual == null ? MessageContainer(message: 'Usual') : usual();
      },
    );
  }

  BlocListener listener({
    Function() initial,
    Function(SuccessTakeState<S>) success,
    Function(FailureTakeState<F>) failure,
    Function() waiting,
    Function() unusual,
    Widget child,
  }) {
    return BlocListener<TakeBloc, TakeState>(
      cubit: _takeBloc,
      listener: (BuildContext context, TakeState takeState) {
        if (takeState is InitialTakeState)
          return initial == null
              ? MessageContainer(message: 'Initial')
              : initial();
        else if (takeState is SuccessTakeState<S>)
          return success == null
              ? MessageContainer(message: 'Success')
              : success(takeState);
        else if (takeState is FailureTakeState<F>)
          return failure == null
              ? MessageContainer(message: 'Failure')
              : failure(takeState);
        else if (takeState is WaitingTakeState)
          return waiting == null ? WaitingContainer() : waiting();
        else
          return unusual == null
              ? MessageContainer(message: 'Unusual')
              : unusual();
      },
      child: child,
    );
  }
}
