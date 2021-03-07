part of 'take_logic.dart';

@immutable
abstract class TakeEvent {}

class SendTakeEvent<V> extends TakeEvent {
  final V value;

  SendTakeEvent([this.value]);
}

class InitiateTakeEvent extends TakeEvent {}
