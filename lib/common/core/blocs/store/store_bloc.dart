import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_logic/common/core/blocs/store/create_store_use_case.dart';
import 'package:bloc_logic/common/core/blocs/store/delete_restore_use_case.dart';
import 'package:bloc_logic/common/core/blocs/store/read_all_store_use_case.dart';
import 'package:bloc_logic/common/core/blocs/store/read_store_use_case.dart';
import 'package:bloc_logic/common/core/blocs/store/store_item.dart';
import 'package:bloc_logic/common/core/blocs/store/store_repository_interface.dart';
import 'package:bloc_logic/common/core/blocs/store/update_store_use_case.dart';
import 'package:bloc_logic/common/core/blocs/store/write_all_store_use_case.dart';
import 'package:bloc_logic/common/data/result.dart';
import 'package:meta/meta.dart';

part 'store_event.dart';

part 'store_state.dart';

class StoreBloc<S, I extends StoreItem, K>
    extends Bloc<StoreEvent, StoreState> {
  final IStoreRepository repository;

  CreateStoreUseCase<I> createStoreUseCase;
  ReadStoreUseCase<K, I> readStoreUseCase;
  UpdateStoreUseCase<I> updateStoreUseCase;
  DeleteStoreUseCase<K, I> deleteStoreUseCase;
  ReadAllStoreUseCase<I> readAllStoreUseCase;
  WriteAllStoreUseCase<I> writeAllStoreUseCase;

  StoreBloc({@required this.repository}) : super(InitialStoreState()) {
    createStoreUseCase = CreateStoreUseCase(repository: repository);
    readStoreUseCase = ReadStoreUseCase(repository: repository);
    updateStoreUseCase = UpdateStoreUseCase(repository: repository);
    deleteStoreUseCase = DeleteStoreUseCase(repository: repository);
    readAllStoreUseCase = ReadAllStoreUseCase(repository: repository);
    writeAllStoreUseCase = WriteAllStoreUseCase(repository: repository);
  }

  @override
  Stream<StoreState> mapEventToState(
    StoreEvent event,
  ) async* {
    if (event is CreateStoreEvent) {
      yield* _createMapEventToState(event);
    } else if (event is ReadStoreEvent) {
      yield* _readMapEventToState(event);
    } else if (event is UpdateStoreEvent) {
      yield* _updateMapEventToState(event);
    } else if (event is DeleteStoreEvent) {
      yield* _deleteMapEventToState(event);
    } else if (event is ReadAllStoreEvent) {
      yield* _readAllMapEventToState(event);
    } else if (event is WriteAllStoreEvent) {
      yield* _writeAllMapEventToState(event);
    }
  }

  Stream<StoreState> _createMapEventToState(CreateStoreEvent event) async* {
    Result result = createStoreUseCase.execute(event.item);
    if (!result.hasFailure())
      yield CreatedStoreState(success: result.success);
    else
      yield FailureStoreState(failure: result.failure);
  }

  Stream<StoreState> _readMapEventToState(ReadStoreEvent event) async* {
    Result result = readStoreUseCase.execute(event.key);
    if (!result.hasFailure())
      yield ReadedStoreState(success: result.success);
    else
      yield FailureStoreState(failure: result.failure);
  }

  Stream<StoreState> _updateMapEventToState(UpdateStoreEvent event) async* {
    Result result = updateStoreUseCase.execute(event.item);
    if (!result.hasFailure())
      yield UpdatedStoreState(success: result.success);
    else
      yield FailureStoreState(failure: result.failure);
  }

  Stream<StoreState> _deleteMapEventToState(DeleteStoreEvent event) async* {
    Result result = deleteStoreUseCase.execute(event.key);
    if (!result.hasFailure())
      yield DeletedStoreState(success: result.success);
    else
      yield FailureStoreState(failure: result.failure);
  }

  Stream<StoreState> _readAllMapEventToState(ReadAllStoreEvent event) async* {
    Result result = readAllStoreUseCase.execute();
    if (!result.hasFailure())
      yield ReadedStoreState(success: result.success);
    else
      yield FailureStoreState(failure: result.failure);
  }

  Stream<StoreState> _writeAllMapEventToState(WriteAllStoreEvent event) async* {
    Result result = writeAllStoreUseCase.execute(event.list);
    if (!result.hasFailure())
      yield WroteStoreState(success: result.success);
    else
      yield FailureStoreState(failure: result.failure);
  }
}
