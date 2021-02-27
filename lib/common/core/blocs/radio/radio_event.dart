part of 'radio_bloc.dart';

@immutable
abstract class RadioEvent {}

class SwitchRadioEvent<V> extends RadioEvent {
  final V index;

  SwitchRadioEvent(this.index);
}
