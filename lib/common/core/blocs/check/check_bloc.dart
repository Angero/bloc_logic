import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_logic/common/data/result.dart';
import 'package:bloc_logic/common/core/usecases/use_case_interface.dart';
import 'package:meta/meta.dart';

part 'check_event.dart';

part 'check_state.dart';

class CheckBloc<UseCase extends IUseCase<String, String, String>>
    extends Bloc<CheckEvent, CheckState> {
  final UseCase usecase;

  CheckBloc({@required this.usecase}) : super(InitialCheckState());

  @override
  Stream<CheckState> mapEventToState(CheckEvent event) async* {
    if (event is ChangeCheckEvent) {
      Result result = usecase.execute(event.value);
      yield ChangedCheckState(result: result);
    }
  }
}
