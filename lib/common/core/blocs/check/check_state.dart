part of 'check_logic.dart';

@immutable
abstract class CheckState {
}

class CheckedCheckState extends CheckState {}

class UncheckedCheckState extends CheckState {}
