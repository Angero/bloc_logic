part of 'radio_logic.dart';

@immutable
abstract class RadioEvent {}

class SelectRadioEvent<V> extends RadioEvent {
  final V index;

  SelectRadioEvent(this.index);
}
