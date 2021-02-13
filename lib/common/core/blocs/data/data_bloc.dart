import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_logic/common/core/usecases/use_case_interface.dart';
import 'package:bloc_logic/common/data/data.dart';
import 'package:bloc_logic/common/data/result.dart';
import 'package:meta/meta.dart';

part 'data_event.dart';

part 'data_state.dart';

class DataBloc<UseCase extends IUseCase<bool, Data, String>>
    extends Bloc<DataEvent, DataState> {
  final Data data;
  final UseCase usecase;

  DataBloc({@required this.data, @required this.usecase})
      : super(InitialDataState());

  @override
  Stream<DataState> mapEventToState(DataEvent event) async* {
    if (event is ChangeDataEvent) {
      data.set(event.key, event.value);
      Result<bool, String> valid = this.usecase.execute(data);
      yield ChangedDataState(
        result: Result<Data, String>(
          success: data,
          failure: valid.success ? '' : 'Data is invalid',
        ),
      );
    }
  }
}
