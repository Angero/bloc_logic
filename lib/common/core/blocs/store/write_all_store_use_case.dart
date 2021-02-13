import 'package:bloc_logic/common/core/blocs/store/store_item.dart';
import 'package:bloc_logic/common/core/blocs/store/store_repository_interface.dart';
import 'package:bloc_logic/common/core/usecases/use_case_interface.dart';
import 'package:bloc_logic/common/data/result.dart';
import 'package:flutter/foundation.dart';

class WriteAllStoreUseCase<I extends StoreItem> implements IUseCase<List<I>, List<I>, String> {
  final IStoreRepository repository;

  WriteAllStoreUseCase({@required this.repository});

  @override
  Result<List<I>, String> execute([List<I> value]) {
    try {
      List<I> items = repository.writeAll(value);
      return Result(success: items);
    } catch (e) {
      return Result(failure: e.toString());
    }
  }
}
