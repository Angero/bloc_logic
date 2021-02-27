import 'package:bloc_logic/common/core/blocs/radio/radio_bloc.dart';
import 'package:bloc_logic/common/view/message_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RadioLogic<S, V, F> {
  RadioBloc _radioBloc;

  RadioLogic() {
    _radioBloc = RadioBloc<S, V, F>();
  }

  void select(index) {
    _radioBloc.add(SwitchRadioEvent(index));
  }

  void dispose() {
    _radioBloc.close();
  }

  BlocBuilder builder({
    Function(V) child,
  }) {
    return BlocBuilder<RadioBloc, RadioState>(
        cubit: _radioBloc,
        builder: (BuildContext context, RadioState radioState) {
          if (radioState is SwitchedRadioState) {
            return child == null
                ? MessageContainer(message: 'Radio')
                : child(radioState.index);
          } else if (radioState is FailureRadioState) {
            return MessageContainer(message: radioState.failure);
          } else {
            return MessageContainer(message: 'Unusual');
          }
        });
  }
}
