import 'package:bloc_logic/common/core/blocs/store/store_item.dart';

class DataItem implements StoreItem<String> {
  @override
  String key;

  String value;

  DataItem({this.key, this.value});
}
