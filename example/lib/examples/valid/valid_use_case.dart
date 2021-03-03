import 'package:bloc_logic/common/core/usecases/use_case_interface.dart';
import 'package:bloc_logic/common/data/result.dart';

class ValidUseCase implements IUseCase<String, String, String> {
  @override
  Result<String, String> execute([String value]) {
    try {
      if (value == null) return Result(success: '');
      if (value.isEmpty) return Result(failure: 'The value must not be empty.');
      if (value.length > 3)
        return Result(failure: 'The value must be less then 4.');
      return Result(success: value);
    } catch (e, stacktrace) {
      print('BLOC_LOGIC: ${e.toString()} STACKTRACE: ${stacktrace.toString()}');
      return Result(failure: e.toString());
    }
  }
}

