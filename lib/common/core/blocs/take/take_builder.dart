import 'package:bloc_logic/common/core/blocs/take/take_bloc.dart';
import 'package:bloc_logic/common/core/blocs/take/take_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TakeBuilder extends StatelessWidget {
  final TakeLogic logic;
  final Function(SuccessTakeState) success;
  final Function(FailureTakeState) failure;
  final Function() waiting;

  const TakeBuilder({
    Key key,
    @required this.logic,
    this.success,
    this.failure,
    this.waiting,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TakeBloc, TakeState>(
        cubit: this.logic.takeBloc,
        builder: (BuildContext context, TakeState takeState) {
          if (takeState is SuccessTakeState)
            return this.success(takeState);
          else if (takeState is FailureTakeState)
            return this.failure(takeState);
          else if (takeState is WaitingTakeState)
            return this.waiting();
          else
            return Container();
        });
  }
}
