import 'package:bloc_logic/common/core/blocs/storage/storage_item.dart';
import 'package:bloc_logic/common/core/blocs/storage/storage_repository_interface.dart';
import 'package:bloc_logic/common/core/usecases/use_case_interface.dart';
import 'package:bloc_logic/common/data/result.dart';
import 'package:flutter/foundation.dart';

class UpdateStorageUseCase<I extends StorageItem> implements IFutureUseCase<List<I>, I, String> {
  final IStorageRepository repository;

  UpdateStorageUseCase({@required this.repository});

  @override
  Future<Result<List<I>, String>> execute([I value]) async {
    try {
      List<I> list = await repository.update(value);
      return Result(success: list);
    } catch (e) {
      return Result(failure: e.toString());
    }
  }

}