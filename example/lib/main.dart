import 'package:bloc_logic_example/examples/take/take_example.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:bloc_logic/bloc_logic.dart';

void main() {
  // runApp(MyApp());
  runApp(MaterialApp(
    home: MainPage(),
    routes: <String, WidgetBuilder>{
      TakeExample.route: (BuildContext context) => TakeExample(),
      //'/second': (BuildContext context) =>  Second(),
      //'/third': (BuildContext context) => Third(),
    },
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Example> list = List();
    list.add(Example('TakeLogic Example', TakeExample.route));
    return Scaffold(
      appBar: AppBar(title: Text('Bloc Logic')),
      body: SafeArea(
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(title: Text(list.elementAt(index).name), onTap: () {
              Navigator.of(context).pushNamed(TakeExample.route);
            },);
          },
        ),
      ),
    );
  }
}


class Example {
  final String name;
  final String route;

  Example(this.name, this.route);
}


////////////////////// todo: remove this?
class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await BlocLogic.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}
