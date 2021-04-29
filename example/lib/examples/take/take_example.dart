import 'package:bloc_logic/bloc_logic.dart';
import 'package:bloc_logic_example/examples/take/take_repository.dart';
import 'package:bloc_logic_example/examples/take/take_use_case.dart';

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
        usecase: TakeUseCase(repository: TakeRepository()));
  }

  @override
  void dispose() {
    _takeLogic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _takeLogic.listener(
      (context, state) {
        if (state is InitialTakeState) print('initial');
        if (state is WaitingTakeState) print('waiting');
        if (state is SuccessTakeState) print(state.success.toString());
        if (state is FailureTakeState) print(state.failure.toString());
      },
      child: _scaffold(),
    );
  }

  Scaffold _scaffold() {
    return Scaffold(
      appBar: AppBar(title: Text('TakeLogic')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20.0),
            Text(
                'This example shows how you can send request to a server and get response. After that you can expose this response like a value list.'),
            SizedBox(height: 20.0),
            RaisedButton(
              child: Text('Get vegetables'),
              onPressed: () {
                _takeLogic.request();
              },
            ),
            _takeLogic.builder((context, state) {
              if (state is InitialTakeState)
                return MessageContainer(message: 'Empty');
              if (state is WaitingTakeState) return WaitingContainer();
              if (state is SuccessTakeState) {
                List<String> list = state.success as List;
                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return ListTile(title: Text(list.elementAt(index)));
                  },
                  separatorBuilder: (context, index) {
                    return Divider(color: Colors.black);
                  },
                );
              }
              if (state is FailureTakeState) print(state.failure.toString());
              return MessageContainer(message: 'Oops');
            }),
          ],
        ),
      ),
    );
  }
}
