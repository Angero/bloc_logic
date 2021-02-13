import 'package:bloc_logic/common/core/blocs/storage/storage_item.dart';
import 'package:bloc_logic/common/core/blocs/storage/storage_repository_interface.dart';
import 'package:bloc_logic/common/core/usecases/use_case_interface.dart';
import 'package:bloc_logic/common/data/result.dart';
import 'package:flutter/foundation.dart';

class DeleteStorageUseCase<K, I extends StorageItem> implements IFutureUseCase<List<I>, K, String> {
  final IStorageRepository repository;

  DeleteStorageUseCase({@required this.repository});

  @override
  Future<Result<List<I>, String>> execute([K value]) async {
    try {
      List<I> list = await repository.delete(value);
      return Result(success: list);
    } catch (e) {
      return Result(failure: e.toString());
    }
  }

}