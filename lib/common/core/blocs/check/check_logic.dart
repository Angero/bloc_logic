import 'package:bloc_logic/bloc_logic.dart';

part 'check_bloc.dart';
part 'check_state.dart';
part 'check_event.dart';

/// **1. DEFINE LOGIC**
/// ```dart
/// CheckLogic _checkLogic;
/// ```
///
/// **2. INITIALIZE LOGIC**
/// ```dart
/// _checkLogic = CheckLogic();
/// ```
///
/// **3. DISPOSE**
/// ```dart
/// _checkLogic.dispose();
/// ```
///
/// **4. LISTENER**
///
/// Available states:
///
/// * CheckedState
/// * UncheckedState
///
/// Example:
///
/// ```dart
/// _checkLogic.listener(
///   (context, state) {
///     if (state is CheckedState)
///       print('checked');
///     else
///       print('unchecked');
///    },
///    child: Container(),
/// )
/// ```
///
/// **5. BUILDER**
///
/// Available states:
///
/// * CheckedState
/// * UncheckedState
///
/// Example:
///
/// ```dart
/// _checkLogic.builder(
///   (context, state) {
///     if (state is CheckedState)
///       print('checked');
///     if (state is UncheckedState)
///       print('unchecked');
///     return Container();
///   }
/// )
///```
///
/// **6. EVENTS**
///
/// * checkEvent()
/// * uncheckEvent()
///
/// Example:
///
/// ```dart
/// _checkLogic.checkEvent();
/// _checkLogic.uncheckEvent();
/// ```
///
class CheckLogic<S, V, F> {
  late CheckBloc _checkBloc;

  CheckLogic() {
    _checkBloc = CheckBloc();
  }

  void dispose() {
    _checkBloc.close();
  }

  void checkEvent() {
    _checkBloc.add(CheckCheckEvent());
  }

  void uncheckEvent() {
    _checkBloc.add(UncheckCheckEvent());
  }

  BlocListener listener(void Function(BuildContext, CheckState) listener,
      {bool Function(CheckState, CheckState)? listenWhen, required Widget child}) {
    return BlocListener<CheckBloc, CheckState>(
      bloc: _checkBloc,
      listener: (BuildContext context, CheckState checkState) {
        listener(context, checkState);
      },
      listenWhen: (CheckState beforeCheckState, CheckState afterCheckState) {
        return listenWhen!(beforeCheckState, afterCheckState);
      },
      child: child,
    );
  }

  BlocBuilder builder(Widget Function(BuildContext, CheckState) builder,
      {bool Function(CheckState, CheckState)? buildWhen}) {
    return BlocBuilder<CheckBloc, CheckState>(
      bloc: _checkBloc,
      builder: (BuildContext context, CheckState checkState) {
        return builder(context, checkState);
      },
      buildWhen: (CheckState beforeCheckState, CheckState afterCheckState) {
        return buildWhen!(beforeCheckState, afterCheckState);
      },
    );
  }

}
