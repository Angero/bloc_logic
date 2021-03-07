import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'radio_bloc.dart';
part 'radio_state.dart';
part 'radio_event.dart';

/// **1. DEFINE LOGIC**
/// ```dart
/// RadioLogic _radioLogic;
/// ```
///
/// **2. INITIALIZE LOGIC**
/// ```dart
/// _radioLogic = RadioLogic();
/// ```
///
/// **3. DISPOSE**
/// ```dart
/// _radioLogic.dispose();
/// ```
///
/// **4. LISTENER**
///
/// Available states:
///
/// * (int) SelectedRadioState
/// * (F) FailureRadioState
///
/// Example:
///
/// ```dart
/// _radioLogic.listener(
///   (context, state) {
///   if (state is SelectedRadioState)
///     print('selected ' + state.index.toString());
///   else
///     print('failure');
///   },
///   child: _scaffoldWidget(),
/// )
/// ```
///
/// **5. BUILDER**
///
/// Available states:
///
/// * (int) SelectedRadioState
/// * (F) FailureRadioState
///
/// Example:
///
/// ```dart
/// _radioLogic.builder(
///   (context, state) {
///      if (state is SelectedRadioState)
///        print('selected ' + state.index.toString());
///      else
///        print('failure');
///     return Container();
///   }
/// )
///```
///
/// **6. EVENTS**
///
/// * selectEvent(index)
///
/// Example:
///
/// ```dart
/// _radioLogic.selectEvent(index);
/// ```
///
class RadioLogic<S, V, F> {
  RadioBloc _radioBloc;

  RadioLogic() {
    _radioBloc = RadioBloc<S, V, F>();
  }

  void dispose() {
    _radioBloc.close();
  }

  void select(index) {
    _radioBloc.add(SelectRadioEvent(index));
  }

  BlocListener listener(void Function(BuildContext, RadioState) listener,
      {bool Function(RadioState, RadioState) listenWhen, Widget child}) {
    return BlocListener<RadioBloc, RadioState>(
      bloc: _radioBloc,
      listener: (BuildContext context, RadioState radioState) {
        listener(context, radioState);
      },
      listenWhen: (RadioState beforeRadioState, RadioState afterRadioState) {
        return listenWhen == null ? null : listenWhen(beforeRadioState, afterRadioState);
      },
      child: child,
    );
  }

  BlocBuilder builder(Widget Function(BuildContext, RadioState) builder,
      {bool Function(RadioState, RadioState) buildWhen}) {
    return BlocBuilder<RadioBloc, RadioState>(
      bloc: _radioBloc,
      builder: (BuildContext context, RadioState radioState) {
        return builder(context, radioState);
      },
      buildWhen: (RadioState beforeRadioState, RadioState afterRadioState) {
        return buildWhen == null ? null : buildWhen(beforeRadioState, afterRadioState);
      },
    );
  }
}
