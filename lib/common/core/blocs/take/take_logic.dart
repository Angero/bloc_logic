import 'dart:async';

import 'package:bloc_logic/bloc_logic.dart';

part 'take_bloc.dart';

part 'take_event.dart';

part 'take_state.dart';

/// **1. DEFINE LOGIC**
/// ```dart
/// TakeLogic _takeLogic;
/// ```
///
/// **2. INITIALIZE LOGIC**
///
/// ```dart
/// _takeLogic = TakeLogic<List<String>, void, String>(
///     usecase: TakeUseCase(repository: TakeRepository()));
/// ```
///
/// **3. DISPOSE**
/// ```dart
/// _takeLogic.dispose();
/// ```
///
/// **4. USE CASE**
///
/// ```dart
/// class TakeUseCase implements IFutureUseCase<List<String>, void, String> {
///   final ITakeRepository repository;
///
///   TakeUseCase({required this.repository});
///
///   @override
///   Future<Result<List<String>, String>> execute([void value]) async {
///     try {
///       List<String> result = await repository.getList();
///       return Result(success: result);
///     } catch (e) {
///       return Result(failure: e.toString());
///     }
///   }
/// }
/// ```
///
/// **5. REPOSITORY**
///
/// ```dart
/// class TakeRepository implements ITakeRepository {
///   @override
///   Future<List<String>> getList() async {
///     await Future.delayed(Duration(milliseconds: 1000));
///     return ['Onion', 'Potato', 'Carrot'];
///   }
/// }
/// ```
///
/// ```dart
/// abstract class ITakeRepository {
///   Future<List<String>> getList();
/// }
/// ```
///
/// **6. LISTENER**
///
/// Available states:
///
/// * InitialTakeState
/// * WaitingTakeState
/// * (S) SuccessTakeState
/// * (F) FailureTakeState
///
/// Example:
///
/// ```dart
/// _takeLogic.listener(
///       (context, state) {
///     if (state is InitialTakeState)
///       print('initial');
///     if (state is WaitingTakeState)
///       print('waiting');
///     if (state is SuccessTakeState)
///       print(state.success.toString());
///     if (state is FailureTakeState)
///       print(state.failure.toString());
///   },
///   child: Container(),
/// )
/// ```
///
/// **7. BUILDER**
///
/// Available states:
///
/// * InitialTakeState
/// * WaitingTakeState
/// * (S) SuccessTakeState
/// * (F) FailureTakeState
///
/// Example:
///
/// ```dart
/// _takeLogic.builder((context, state) {
///   if (state is InitialTakeState)
///     return MessageContainer(message: 'Empty');
///   if (state is WaitingTakeState)
///     return WaitingContainer();
///   if (state is SuccessTakeState)
///     return MessageContainer(message: state.success.toString());
///   if (state is FailureTakeState)
///     return MessageContainer(message: state.failure.toString());
///   return MessageContainer(message: 'Oops');
/// })
///```
///
/// **8. EVENTS**
///
/// * request()
///
/// Example:
///
/// ```dart
/// _takeLogic.request([V]);
/// ```
///
class TakeLogic<S, V, F> {
  late TakeBloc<S, V, F> _takeBloc;

  TakeLogic({required IFutureUseCase<S, V, F> usecase}) {
    _takeBloc = TakeBloc<S, V, F>(usecase: usecase);
  }

  void dispose() {
    _takeBloc.close();
  }

  void request([V? value]) {
    _takeBloc.add(SendTakeEvent(value));
  }

  BlocListener listener(void Function(BuildContext, TakeState) listener,
      {bool Function(TakeState, TakeState)? listenWhen,
      required Widget child}) {
    return BlocListener<TakeBloc, TakeState>(
      bloc: _takeBloc,
      listener: (BuildContext context, TakeState takeState) {
        listener(context, takeState);
      },
      listenWhen: (TakeState beforeTakeState, TakeState afterTakeState) {
        return listenWhen == null
            ? true
            : listenWhen(beforeTakeState, afterTakeState);
      },
      child: child,
    );
  }

  BlocBuilder builder(Widget Function(BuildContext, TakeState) builder,
      {bool Function(TakeState, TakeState)? buildWhen}) {
    return BlocBuilder<TakeBloc, TakeState>(
      bloc: _takeBloc,
      builder: (BuildContext context, TakeState takeState) {
        return builder(context, takeState);
      },
      buildWhen: (TakeState beforeTakeState, TakeState afterTakeState) {
        return buildWhen == null
            ? true
            : buildWhen(beforeTakeState, afterTakeState);
      },
    );
  }
}
