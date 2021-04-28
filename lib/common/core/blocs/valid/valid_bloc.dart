part of 'valid_logic.dart';

class ValidBloc<S, V, F> extends Bloc<ValidEvent, ValidState> {
  final IUseCase<S, V, F> usecase;

  ValidBloc({required this.usecase})
      : super(ValidatedValidState(result: Result(success: null)));

  @override
  Stream<ValidState> mapEventToState(ValidEvent event) async* {
    if (event is ValidateValidEvent) {
      if (event.value == null)
        yield ValidatedValidState(result: Result(success: null));
      else {
        Result<S, F> result = this.usecase.execute(event.value);
        yield ValidatedValidState(result: result);
      }
    } else if (event is InitialValidEvent) {
      yield ValidatedValidState(result: Result(success: null));
    }
  }
}
