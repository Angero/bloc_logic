import 'package:bloc_logic/common/core/blocs/store/store_bloc.dart';
import 'package:bloc_logic_example/examples/store/data_item.dart';
import 'package:bloc_logic_example/examples/store/store_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoreExample extends StatefulWidget {
  @override
  _StoreExampleState createState() => _StoreExampleState();
}

class _StoreExampleState extends State<StoreExample> {
  StoreBloc _storeBloc;

  @override
  void initState() {
    super.initState();
    _storeBloc = StoreBloc(repository: StoreRepository.instance)
      ..add(ReadAllStoreEvent());
  }

  @override
  void dispose() {
    _storeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 200.0),
              _blocBuilder(),
              MaterialButton(
                child: new Text('Press me'),
                minWidth: 120.0,
                height: 50.0,
                color: Colors.deepOrange,
                textColor: Colors.white,
                onPressed: () {
                  _storeBloc.add(CreateStoreEvent(
                      item: DataItem(key: '1', value: 'Tomato')));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _blocBuilder() {
    return BlocBuilder<StoreBloc, StoreState>(
        cubit: _storeBloc,
        builder: (BuildContext context, StoreState storeState) {
          if (storeState is ReadedStoreState) {
            return Text(
                (storeState.success as List<DataItem>).length.toString());
          }
          if (storeState is CreatedStoreState) {
            return Text(
                (storeState.success as List<DataItem>).length.toString());
          }
          return Text('Oops!');
        });
  }
}
