import 'package:bloc_logic/common/core/blocs/check/check_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckLogic<S, V, F> {
  CheckBloc _checkBloc;
  bool _isTurnedOn;

  bool get isTurnedOn => _isTurnedOn;

  CheckBloc get checkBloc => _checkBloc;

  CheckLogic() {
    _isTurnedOn = false;
    _checkBloc = CheckBloc();
  }

  void dispose() {
    _checkBloc.close();
  }

  void turnOn() {
    _isTurnedOn = true;
    _checkBloc.add(TurnOnCheckEvent());
  }

  void turnOff() {
    _isTurnedOn = false;
    _checkBloc.add(TurnOffCheckEvent());
  }

  BlocBuilder builder({
    Function() child,
  }) {
    return BlocBuilder<CheckBloc, CheckState>(
        cubit: _checkBloc,
        builder: (BuildContext context, CheckState checkState) {
          _isTurnedOn = checkState is OnCheckState;
          return child();
        });
  }
}
