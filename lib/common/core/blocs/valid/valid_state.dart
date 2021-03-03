part of 'valid_logic.dart';

@immutable
abstract class ValidState {}

class ValidatedValidState extends ValidState {
  final Result result;

  ValidatedValidState({@required this.result});
}
