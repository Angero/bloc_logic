part of 'take_logic.dart';


class TakeBloc<S, V, F> extends Bloc<TakeEvent, TakeState> {
  final IFutureUseCase<S, V, F> usecase;

  TakeBloc({@required this.usecase}) : super(InitialTakeState());

  @override
  Stream<TakeState> mapEventToState(TakeEvent event) async* {
    if (event is SendTakeEvent) {
      yield WaitingTakeState();
      try {
        Result<S, F> result = await usecase.execute(event.value);
        if (!result.hasFailure())
          yield SuccessTakeState<S>(result.success);
        else
          yield FailureTakeState<F>(result.failure);
      } catch (e, stacktrace) {
        print('BLOC_LOGIC: ${e.toString()} STACKTRACE: ${stacktrace.toString()}');
        yield FailureTakeState(e.toString()); //todo:
      }
    } else if (event is InitiateTakeEvent) {
      yield InitialTakeState();
    }
  }
}
