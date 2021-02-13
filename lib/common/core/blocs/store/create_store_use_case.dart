import 'package:bloc_logic/common/core/blocs/store/store_item.dart';
import 'package:bloc_logic/common/core/blocs/store/store_repository_interface.dart';
import 'package:bloc_logic/common/core/usecases/use_case_interface.dart';
import 'package:bloc_logic/common/data/result.dart';
import 'package:flutter/foundation.dart';

class CreateStoreUseCase<I extends StoreItem> implements IUseCase<List<I>, I, String> {
  final IStoreRepository repository;

  CreateStoreUseCase({@required this.repository});

  @override
  Result<List<I>, String> execute([I item]) {
    try {
      List<I> list = repository.create(item);
      return Result(success: list);
    } catch (e) {
      return Result(failure: e.toString());
    }
  }

}