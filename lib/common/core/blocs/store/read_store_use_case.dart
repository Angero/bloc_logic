import 'package:bloc_logic/common/core/blocs/store/store_item.dart';
import 'package:bloc_logic/common/core/blocs/store/store_repository_interface.dart';
import 'package:bloc_logic/common/core/usecases/use_case_interface.dart';
import 'package:bloc_logic/common/data/result.dart';
import 'package:flutter/foundation.dart';

class ReadStoreUseCase<K, I extends StoreItem> implements IUseCase<I, K, String> {
  final IStoreRepository repository;

  ReadStoreUseCase({@required this.repository});

  @override
  Result<I, String> execute([K value]) {
    try {
      I item = repository.read(value);
      return Result(success: item);
    } catch (e) {
      return Result(failure: e.toString());
    }
  }
}
