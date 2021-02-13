import 'package:bloc_logic/common/core/blocs/store/store_item.dart';
import 'package:bloc_logic/common/core/blocs/store/store_repository_interface.dart';
import 'package:bloc_logic/common/core/usecases/use_case_interface.dart';
import 'package:bloc_logic/common/data/result.dart';
import 'package:flutter/foundation.dart';

class ReadAllStoreUseCase<I extends StoreItem> implements IUseCase<List<I>, void, String> {
  final IStoreRepository repository;

  ReadAllStoreUseCase({@required this.repository});

  @override
  Result<List<I>, String> execute([void value]) {
    try {
      List<I> items = repository.readAll();
      return Result(success: items);
    } catch (e) {
      return Result(failure: e.toString());
    }
  }
}
