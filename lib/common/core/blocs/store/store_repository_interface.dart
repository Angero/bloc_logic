import 'package:bloc_logic/common/core/blocs/store/store_item.dart';

abstract class IStoreRepository<I extends StoreItem, K> {
  List<I> create(I item);

  I read(K key);

  List<I> update(I item);

  List<I> delete(K key);

  List<I> readAll();

  List<I> writeAll(List<I> list);
}
