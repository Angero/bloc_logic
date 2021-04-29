import 'package:bloc_logic/bloc_logic.dart';
import 'package:bloc_logic_example/examples/valid/valid_use_case.dart';

class ValidExample extends StatefulWidget {
  static const String route = '/valid_example';

  @override
  _ValidExampleState createState() => new _ValidExampleState();
}

class _ValidExampleState extends State<ValidExample> {
  ValidLogic _validLogic;
  TextEditingController _validController;

  @override
  void initState() {
    super.initState();
    _validLogic = ValidLogic(usecase: ValidUseCase());
    _validController = TextEditingController();
  }

  @override
  void dispose() {
    _validLogic.dispose();
    _validController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _validLogic.listener(
          (context, state) {
        if (state is ValidatedValidState)
          print('valided');
        else
          print('unvalided');
      },
      child: _scaffoldWidget(),
    );
  }

  Widget _scaffoldWidget() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Valid Logic Example'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 10.0),
              Text(
                  'This example shows how you can control length input string.'),
              _validLogic.builder(
                (context, state) {
                  Result _result = (state as ValidatedValidState).result;
                  return TextField(
                    controller: _validController,
                    decoration: InputDecoration(
                      errorText: _result.hasFailure() ? _result.failure : null,
                    ),
                    onChanged: (value) {
                      _validLogic.validate(value);
                    },
                  );
                },
              ),
              SizedBox(height: 10.0),
              RaisedButton(
                child: Text('Refresh'),
                onPressed: () {
                  _validController.text = '';
                  _validLogic.validate();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
