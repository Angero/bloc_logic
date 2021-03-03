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
    return _checkLogic.listener(
      (context, state) {
        if (state is CheckedCheckState)
          print('checked');
        else
          print('unchecked');
      },
      child: _scaffoldWidget(),
    );
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
                  (context, state) {
                    return RaisedButton(
                      child:
                          Text(state is CheckedCheckState ? 'Turn on' : 'Turn off'),
                      color: state is CheckedCheckState
                          ? Colors.deepOrange
                          : Colors.green,
                      textColor: Colors.white,
                      onPressed: () {
                        if (state is CheckedCheckState)
                          _checkLogic.uncheckEvent();
                        else
                          _checkLogic.checkEvent();
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
