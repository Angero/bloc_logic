part of 'valid_bloc.dart';

@immutable
abstract class ValidState {}

class ChangedValidState extends ValidState {
  final Result result;

  ChangedValidState({@required this.result});
}
