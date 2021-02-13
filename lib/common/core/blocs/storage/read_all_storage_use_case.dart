import 'package:bloc_logic/common/core/blocs/storage/storage_item.dart';
import 'package:bloc_logic/common/core/blocs/storage/storage_repository_interface.dart';
import 'package:bloc_logic/common/core/usecases/use_case_interface.dart';
import 'package:bloc_logic/common/data/result.dart';
import 'package:flutter/foundation.dart';

class ReadAllStorageUseCase<I extends StorageItem> implements IFutureUseCase<List<I>, void, String> {
  final IStorageRepository repository;

  ReadAllStorageUseCase({@required this.repository});

  @override
  Future<Result<List<I>, String>> execute([void value]) async {
    try {
      List<I> items = await repository.readAll();
      return Result(success: items);
    } catch (e) {
      return Result(failure: e.toString());
    }
  }
}
