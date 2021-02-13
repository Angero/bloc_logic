import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_logic/common/core/usecases/use_case_interface.dart';
import 'package:meta/meta.dart';

part 'tab_event.dart';

part 'tab_state.dart';

class TabBloc<UseCase extends IUseCase> extends Bloc<TabEvent, TabState> {
  final UseCase usecase;

  TabBloc({@required this.usecase}) : super(SwitchedTabState(0));

  @override
  Stream<TabState> mapEventToState(TabEvent event) async* {
    if (event is SwitchTabEvent) {
      int i = usecase.execute(event.index).success;
      yield SwitchedTabState(i);
    }
  }
}
