part of 'storage_bloc.dart';

@immutable
abstract class StorageState {}

class InitialStorageState extends StorageState {}

class SuccessStorageState<S> extends StorageState {
  final S success;

  SuccessStorageState({@required this.success});
}

class CreatedStorageState extends SuccessStorageState {
  CreatedStorageState({@required success}) : super(success: success);
}

class ReadedStorageState extends SuccessStorageState {
  ReadedStorageState({@required success}) : super(success: success);
}

class UpdatedStorageState extends SuccessStorageState {
  UpdatedStorageState({@required success}) : super(success: success);
}

class DeletedStorageState extends SuccessStorageState {
  DeletedStorageState({@required success}) : super(success: success);
}

class FailureStorageState<F> extends StorageState {
  final F failure;

  FailureStorageState({@required this.failure});
}
