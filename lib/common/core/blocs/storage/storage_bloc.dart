import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_logic/common/core/blocs/storage/create_storage_use_case.dart';
import 'package:bloc_logic/common/core/blocs/storage/delete_storage_use_case.dart';
import 'package:bloc_logic/common/core/blocs/storage/read_all_storage_use_case.dart';
import 'package:bloc_logic/common/core/blocs/storage/read_storage_use_case.dart';
import 'package:bloc_logic/common/core/blocs/storage/storage_item.dart';
import 'package:bloc_logic/common/core/blocs/storage/storage_repository_interface.dart';
import 'package:bloc_logic/common/core/blocs/storage/update_storage_use_case.dart';
import 'package:bloc_logic/common/data/result.dart';
import 'package:meta/meta.dart';

part 'storage_event.dart';

part 'storage_state.dart';

class StorageBloc<S, I extends StorageItem, K>
    extends Bloc<StorageEvent, StorageState> {
  final IStorageRepository repository;

  CreateStorageUseCase<I> createStorageUseCase;
  ReadStorageUseCase<K, I> readStorageUseCase;
  UpdateStorageUseCase<I> updateStorageUseCase;
  DeleteStorageUseCase<K, I> deleteStorageUseCase;
  ReadAllStorageUseCase<I> readAllStorageUseCase;

  StorageBloc({@required this.repository}) : super(InitialStorageState()) {
    createStorageUseCase = CreateStorageUseCase(repository: repository);
    readStorageUseCase = ReadStorageUseCase(repository: repository);
    updateStorageUseCase = UpdateStorageUseCase(repository: repository);
    deleteStorageUseCase = DeleteStorageUseCase(repository: repository);
    readAllStorageUseCase = ReadAllStorageUseCase(repository: repository);
  }

  @override
  Stream<StorageState> mapEventToState(
    StorageEvent event,
  ) async* {
    if (event is CreateStorageEvent) {
      yield* _createMapEventToState(event);
    } else if (event is ReadStorageEvent) {
      yield* _readMapEventToState(event);
    } else if (event is UpdateStorageEvent) {
      yield* _updateMapEventToState(event);
    } else if (event is DeleteStorageEvent) {
      yield* _deleteMapEventToState(event);
    } else if (event is ReadAllStorageEvent) {
      yield* _readAllMapEventToState(event);
    }
  }

  Stream<StorageState> _createMapEventToState(CreateStorageEvent event) async* {
    Result result = await createStorageUseCase.execute(event.item);
    if (!result.hasFailure())
      yield CreatedStorageState(success: result.success);
    else
      yield FailureStorageState(failure: result.failure);
  }

  Stream<StorageState> _readMapEventToState(ReadStorageEvent event) async* {
    Result result = await readStorageUseCase.execute(event.key);
    if (!result.hasFailure())
      yield ReadedStorageState(success: result.success);
    else
      yield FailureStorageState(failure: result.failure);
  }

  Stream<StorageState> _updateMapEventToState(UpdateStorageEvent event) async* {
    Result result = await updateStorageUseCase.execute(event.item);
    if (!result.hasFailure())
      yield UpdatedStorageState(success: result.success);
    else
      yield FailureStorageState(failure: result.failure);
  }

  Stream<StorageState> _deleteMapEventToState(DeleteStorageEvent event) async* {
    Result result = await deleteStorageUseCase.execute(event.key);
    if (!result.hasFailure())
      yield DeletedStorageState(success: result.success);
    else
      yield FailureStorageState(failure: result.failure);
  }

  Stream<StorageState> _readAllMapEventToState(
      ReadAllStorageEvent event) async* {
    Result result = await readAllStorageUseCase.execute();
    if (!result.hasFailure())
      yield ReadedStorageState(success: result.success);
    else
      yield FailureStorageState(failure: result.failure);
  }
}
