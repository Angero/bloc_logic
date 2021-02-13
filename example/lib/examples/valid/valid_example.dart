import 'package:bloc_logic/common/core/blocs/valid/valid_logic.dart';
import 'package:bloc_logic_example/examples/valid/valid_use_case.dart';
import 'package:flutter/material.dart';

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _scaffoldWidget();
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
              Text('This example shows how you can control length input string.'),
              _validLogic.builder(valid: (state) {
                return TextField(
                  controller: _validController,
                  decoration: InputDecoration(
                    errorText:
                        state.result.hasFailure() ? state.result.failure : null,
                  ),
                  onChanged: (value) {
                    _validLogic.validate(value);
                  },
                );
              }),
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
