import 'package:bloc_logic/common/core/blocs/take/take_logic.dart';
import 'package:bloc_logic/common/view/failure_container.dart';
import 'package:bloc_logic/common/view/initial_container.dart';
import 'package:bloc_logic/common/view/oops_container.dart';
import 'package:bloc_logic/common/view/waiting_container.dart';
import 'package:bloc_logic_example/examples/take/take_repository.dart';
import 'package:bloc_logic_example/examples/take/take_use_case.dart';
import 'package:flutter/material.dart';

class TakeExample extends StatefulWidget {
  static const String route = '/take_example';

  @override
  _TakeExampleState createState() => new _TakeExampleState();
}

class _TakeExampleState extends State<TakeExample> {
  TakeLogic _takeLogic;

  @override
  void initState() {
    super.initState();
    _takeLogic = TakeLogic<List<String>, void, String>(
        usecase: TakeUseCase(repository: TakeRepository()))
      ..request();
  }

  @override
  void dispose() {
    _takeLogic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _scaffold();
  }

  Scaffold _scaffold() {
    return Scaffold(
      appBar: AppBar(title: Text('TakeLogic')),
      body: _takeLogic.builder(
        initial: () => InitialContainer(),
        success: (state) {
          return Center(
            child: Text(state.success.toString()),
          );
        },
        failure: (state) => FailureContainer(error: state.failure),
        waiting: () => WaitingContainer(),
        unknown: () => OopsContainer(),
      ),
    );
  }
}
