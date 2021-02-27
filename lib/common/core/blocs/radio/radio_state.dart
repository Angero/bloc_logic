part of 'radio_bloc.dart';

@immutable
abstract class RadioState {}

class SwitchedRadioState<V> extends RadioState {
  final V index;

  SwitchedRadioState(this.index);
}

class FailureRadioState<F> extends RadioState {
  final F failure;

  FailureRadioState(this.failure);
}

