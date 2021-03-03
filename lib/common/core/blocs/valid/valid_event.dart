part of 'valid_logic.dart';

@immutable
abstract class ValidEvent {}

class InitialValidEvent<V> extends ValidEvent {}

class ValidateValidEvent<V> extends ValidEvent {
  final V value;

  ValidateValidEvent(this.value);
}
