part of 'store_bloc.dart';

@immutable
abstract class StoreEvent {}

class CreateStoreEvent<I extends StoreItem> extends StoreEvent {
  final I item;

  CreateStoreEvent({@required this.item});
}

class ReadStoreEvent<K> extends StoreEvent {
  final K key;

  ReadStoreEvent({@required this.key});
}

class UpdateStoreEvent<I extends StoreItem> extends StoreEvent {
  final I item;

  UpdateStoreEvent({@required this.item});
}

class DeleteStoreEvent<K> extends StoreEvent {
  final K key;

  DeleteStoreEvent({@required this.key});
}

class ReadAllStoreEvent extends StoreEvent {}

class WriteAllStoreEvent<I extends StoreItem> extends StoreEvent {
  final List<I> list;

  WriteAllStoreEvent({@required this.list});
}
