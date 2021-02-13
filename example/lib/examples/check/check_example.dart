import 'package:bloc_logic/common/core/blocs/check/check_logic.dart';
import 'package:flutter/material.dart';

class CheckExample extends StatefulWidget {
  static const String route = '/check_example';

  @override
  _CheckExampleState createState() => _CheckExampleState();
}

class _CheckExampleState extends State<CheckExample> {
  CheckLogic _checkLogic;

  @override
  void initState() {
    super.initState();
    _checkLogic = CheckLogic();
  }

  @override
  void dispose() {
    _checkLogic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _scaffoldWidget();
  }

  Widget _scaffoldWidget() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Check Logic Example'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 20.0),
                Text(
                    'This example shows how you can turn on or turn off any parameter.'),
                SizedBox(height: 20.0),
                _checkLogic.builder(
                  child: _materialButton,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  MaterialButton _materialButton() {
    return MaterialButton(
      child: Text(_checkLogic.isTurnedOn ? 'Turn on' : 'Turn off'),
      minWidth: 120.0,
      height: 50.0,
      color: _checkLogic.isTurnedOn ? Colors.deepOrange : Colors.green,
      textColor: Colors.white,
      onPressed: () {
        if (_checkLogic.isTurnedOn)
          _checkLogic.turnOff();
        else
          _checkLogic.turnOn();
      },
    );
  }
}
