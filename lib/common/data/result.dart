class Result<Success, Failure> {
  final Success success;
  final Failure failure;

  Result({this.success, this.failure});

  bool hasFailure() => this.failure != null;
}

