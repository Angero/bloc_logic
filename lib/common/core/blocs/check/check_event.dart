part of 'check_bloc.dart';

@immutable
abstract class CheckEvent {}

class TurnOnCheckEvent extends CheckEvent {}

class TurnOffCheckEvent extends CheckEvent {}