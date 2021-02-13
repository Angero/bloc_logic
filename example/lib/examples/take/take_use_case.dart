import 'package:bloc_logic/common/core/usecases/use_case_interface.dart';
import 'package:bloc_logic/common/data/result.dart';
import 'package:bloc_logic_example/examples/take/take_repository_interface.dart';
import 'package:flutter/foundation.dart';

class TakeUseCase implements IFutureUseCase<List<String>, void, String> {
  final ITakeRepository repository;

  TakeUseCase({@required this.repository});

  @override
  Future<Result<List<String>, String>> execute([void value]) async {
    try {
      List<String> result = await repository.getList();
      return Result(success: result);
    } catch (e) {
      return Result(failure: e.toString());
    }
  }
}
