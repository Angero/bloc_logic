part of 'check_logic.dart';

@immutable
abstract class CheckEvent {}

class CheckCheckEvent extends CheckEvent {}

class UncheckCheckEvent extends CheckEvent {}