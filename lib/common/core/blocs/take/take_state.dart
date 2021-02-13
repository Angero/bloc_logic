part of 'take_bloc.dart';

@immutable
abstract class TakeState {}

class InitialTakeState extends TakeState {}

class WaitingTakeState extends TakeState {}

class SuccessTakeState<S> extends TakeState {
  final S success;

  SuccessTakeState(this.success);
}

class FailureTakeState<F> extends TakeState {
  final F failure;

  FailureTakeState(this.failure);
}
