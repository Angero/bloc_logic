import 'package:bloc_logic/common/core/blocs/storage/storage_item.dart';
import 'package:bloc_logic/common/core/blocs/storage/storage_repository_interface.dart';
import 'package:bloc_logic/common/core/usecases/use_case_interface.dart';
import 'package:bloc_logic/common/data/result.dart';
import 'package:flutter/foundation.dart';

class ReadStorageUseCase<K, I extends StorageItem> implements IFutureUseCase<I, K, String> {
  final IStorageRepository repository;

  ReadStorageUseCase({@required this.repository});

  @override
  Future<Result<I, String>> execute([K value]) async {
    try {
      I item = await repository.read(value);
      return Result(success: item);
    } catch (e) {
      return Result(failure: e.toString());
    }
  }
}
