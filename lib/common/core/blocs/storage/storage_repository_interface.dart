import 'package:bloc_logic/common/core/blocs/storage/storage_item.dart';

abstract class IStorageRepository<I extends StorageItem, K> {
  Future<I> create(I item);

  Future<I> read(K key);

  Future<List<I>> update(I item);

  Future<List<I>> delete(K key);

  Future<List<I>> readAll();
}
