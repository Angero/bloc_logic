part of 'valid_bloc.dart';

@immutable
abstract class ValidEvent {}

class InitialValidEvent<V> extends ValidEvent {}

class ChangeValidEvent<V> extends ValidEvent {
  final V value;

  ChangeValidEvent(this.value);
}
