import 'package:bloc_logic_example/examples/take/take_repository_interface.dart';

class TakeRepository implements ITakeRepository {
  @override
  Future<List<String>> getList() async {
    await Future.delayed(Duration(milliseconds: 1000));
    return ['Onion', 'Potato', 'Carrot'];
  }
}
