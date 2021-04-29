import 'package:bloc_logic/bloc_logic.dart';
import 'package:bloc_logic_example/examples/take/take_repository_interface.dart';

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
