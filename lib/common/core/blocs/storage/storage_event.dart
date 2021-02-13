part of 'storage_bloc.dart';

@immutable
abstract class StorageEvent {}

class CreateStorageEvent<I extends StorageItem> extends StorageEvent {
  final I item;

  CreateStorageEvent({@required this.item});
}

class ReadStorageEvent<K> extends StorageEvent {
  final K key;

  ReadStorageEvent({@required this.key});
}

class UpdateStorageEvent<I extends StorageItem> extends StorageEvent {
  final I item;

  UpdateStorageEvent({@required this.item});
}

class DeleteStorageEvent<K> extends StorageEvent {
  final K key;

  DeleteStorageEvent({@required this.key});
}

class ReadAllStorageEvent extends StorageEvent {}
