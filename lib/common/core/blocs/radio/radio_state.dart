part of 'radio_logic.dart';

@immutable
abstract class RadioState {}

class SelectedRadioState<V> extends RadioState {
  final V index;

  SelectedRadioState(this.index);
}

class FailureRadioState<F> extends RadioState {
  final F failure;

  FailureRadioState(this.failure);
}

