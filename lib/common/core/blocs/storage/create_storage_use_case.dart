import 'package:bloc_logic/common/core/blocs/storage/storage_item.dart';
import 'package:bloc_logic/common/core/blocs/storage/storage_repository_interface.dart';
import 'package:bloc_logic/common/core/usecases/use_case_interface.dart';
import 'package:bloc_logic/common/data/result.dart';
import 'package:flutter/foundation.dart';

class CreateStorageUseCase<I extends StorageItem> implements IFutureUseCase<I, I, String> {
  final IStorageRepository repository;

  CreateStorageUseCase({@required this.repository});

  @override
  Future<Result<I, String>> execute([I input]) async {
    try {
      I output = await repository.create(input);
      return Result(success: output);
    } catch (e) {
      return Result(failure: e.toString());
    }
  }

}