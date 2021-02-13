part of 'check_bloc.dart';

@immutable
abstract class CheckState {}

class OnCheckState extends CheckState {}

class OffCheckState extends CheckState {}
