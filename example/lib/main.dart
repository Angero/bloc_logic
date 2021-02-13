import 'package:bloc_logic_example/examples/check/check_example.dart';
import 'package:bloc_logic_example/examples/take/take_example.dart';
import 'package:bloc_logic_example/examples/valid/valid_example.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MainPage(),
    routes: <String, WidgetBuilder>{
      TakeExample.route: (BuildContext context) => TakeExample(),
      ValidExample.route: (BuildContext context) => ValidExample(),
      CheckExample.route: (BuildContext context) => CheckExample(),
    },
  ));
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Example> list = List();
    list.add(Example('TakeLogic Example', TakeExample.route));
    list.add(Example('ValidLogic Example', ValidExample.route));
    list.add(Example('CheckLogic Example', CheckExample.route));
    return Scaffold(
      appBar: AppBar(title: Text('Bloc Logic')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SizedBox(height: 20.0),
              Text(
                'Bloc Logic Examples',
                style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              SizedBox(height: 20.0),
              ListView.builder(
                shrinkWrap: true,
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return RaisedButton(
                    child: Text(list.elementAt(index).name),
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(list.elementAt(index).route);
                    },
                  );
                  return ListTile(
                    title: Text(list.elementAt(index).name),
                    onTap: () {
                      Navigator.of(context).pushNamed(TakeExample.route);
                    },
                  );
                },
              ),
            ],
          ),
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
