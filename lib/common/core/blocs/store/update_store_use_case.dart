import 'package:bloc_logic/common/core/blocs/store/store_item.dart';
import 'package:bloc_logic/common/core/blocs/store/store_repository_interface.dart';
import 'package:bloc_logic/common/core/usecases/use_case_interface.dart';
import 'package:bloc_logic/common/data/result.dart';
import 'package:flutter/foundation.dart';

class UpdateStoreUseCase<I extends StoreItem> implements IUseCase<List<I>, I, String> {
  final IStoreRepository repository;

  UpdateStoreUseCase({@required this.repository});

  @override
  Result<List<I>, String> execute([I value]) {
    try {
      List<I> list = repository.update(value);
      return Result(success: list);
    } catch (e) {
      return Result(failure: e.toString());
    }
  }

}