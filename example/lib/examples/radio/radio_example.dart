import 'package:bloc_logic/common/core/blocs/radio/radio_logic.dart';
import 'package:flutter/material.dart';

class RadioExample extends StatefulWidget {
  static const String route = '/radio_example';

  @override
  _RadioExampleState createState() => new _RadioExampleState();
}

class _RadioExampleState extends State<RadioExample> {
  RadioLogic _radioLogic;

  @override
  void initState() {
    _radioLogic = RadioLogic();
    super.initState();
  }

  @override
  void dispose() {
    _radioLogic.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _radioLogic.listener(
      (context, state) {
        if (state is SelectedRadioState)
          print('selected ' + state.index.toString());
        else if (state is FailureRadioState)
          print('failure');
      },
      child: _scaffoldWidget(),
    );
  }

  Widget _scaffoldWidget() {
    List<String> list = List<String>.generate(5, (index) => 'Radio $index');
    return Scaffold(
      appBar: AppBar(
        title: Text('Radio Logic Example'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 20.0),
                Text(
                    'This example shows how you can choose only one item in the object list.'),
                SizedBox(height: 20.0),
                _radioLogic.builder(
                  (context, state) {
                    if (state is SelectedRadioState) {
                      print('selected ' + state.index.toString());
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: list.length,
                          itemBuilder: (context, index) {
                            return Center(
                              child: RaisedButton(
                                child: Text(list.elementAt(index)),
                                color: index == state.index
                                    ? Colors.deepOrange
                                    : null,
                                onPressed: () {
                                  _radioLogic.select(index);
                                },
                              ),
                            );
                          });
                    } else {
                      print('failure');
                      return Center(
                        child: Text('Failure'),
                      );
                    }
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
