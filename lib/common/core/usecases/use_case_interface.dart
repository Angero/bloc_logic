import 'package:bloc_logic/common/data/result.dart';

abstract class IUseCase<S, V, F> {
  Result<S, F> execute([V value]);
}

abstract class IFutureUseCase<S, V, F> {
  Future<Result<S, F>> execute([V value]);
}