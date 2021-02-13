import 'package:bloc_logic/common/core/blocs/store/store_repository_interface.dart';
import 'package:bloc_logic_example/examples/store/data_item.dart';
// import 'package:bloc_logic/examples/store/data_item.dart';

class StoreRepository implements IStoreRepository<DataItem, String> {

  StoreRepository._();

  static final instance = StoreRepository._();

  List<DataItem> _list;

  @override
  List<DataItem> create(DataItem item) {
    _list ??= List();
    _list.add(item);
    return _list;
  }

  @override
  List<DataItem> delete(String key) {
    _list ??= List();
    for (DataItem dataItem  in _list) {
      if (dataItem.key == key) _list.remove(dataItem);
    }
    return _list;
  }

  @override
  DataItem read(String key) {
    _list ??= List();
    for (DataItem dataItem  in _list) {
      if (dataItem.key == key) return dataItem;
    }
    return null;
  }

  @override
  List<DataItem> readAll() {
    _list ??= List();
    return _list;
  }

  @override
  List<DataItem> update(DataItem item) {
    _list ??= List();
    for (DataItem dataItem  in _list) {
      if (dataItem.key == item.key) dataItem.value = item.value;
    }
    return _list;
  }

  @override
  List<DataItem> writeAll(List<DataItem> list) {
    _list.addAll(list);
    return _list;
  }
}