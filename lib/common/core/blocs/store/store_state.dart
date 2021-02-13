part of 'store_bloc.dart';

@immutable
abstract class StoreState {}

class InitialStoreState extends StoreState {}

class SuccessStoreState<S> extends StoreState {
  final S success;

  SuccessStoreState({@required this.success});
}

class CreatedStoreState extends SuccessStoreState {
  CreatedStoreState({@required success}) : super(success: success);
}

class ReadedStoreState extends SuccessStoreState {
  ReadedStoreState({@required success}) : super(success: success);
}

class WroteStoreState extends SuccessStoreState {
  WroteStoreState({@required success}) : super(success: success);
}

class UpdatedStoreState extends SuccessStoreState {
  UpdatedStoreState({@required success}) : super(success: success);
}

class DeletedStoreState extends SuccessStoreState {
  DeletedStoreState({@required success}) : super(success: success);
}

class FailureStoreState<F> extends StoreState {
  final F failure;

  FailureStoreState({@required this.failure});
}
