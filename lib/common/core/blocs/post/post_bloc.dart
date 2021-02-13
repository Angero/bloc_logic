import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_logic/common/core/usecases/use_case_interface.dart';
import 'package:bloc_logic/common/data/result.dart';
import 'package:meta/meta.dart';

part 'post_event.dart';

part 'post_state.dart';

class PostBloc<UseCase extends IFutureUseCase> extends Bloc<PostEvent, PostState> {
  final UseCase usecase;

  PostBloc({@required this.usecase}) : super(InitialPostState());

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if (event is SendPostEvent) {
      yield WaitingPostState();
      try {
        Result<bool, String> result = await usecase.execute(event.value);
        if (!result.hasFailure())
          yield SuccessPostState();
        else
          yield FailurePostState(result.failure);
      } catch (e, stacktrace) {
        print('RA: ${e.toString()} STACKTRACE: ${stacktrace.toString()}');
        yield FailurePostState(e.toString());
      }
    } else if (event is InitiatePostEvent) {
      yield InitialPostState();
    }
  }
}
