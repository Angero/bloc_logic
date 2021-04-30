class Failure {
  final int? code;
  final String? message;

  Failure({this.code, this.message});

  bool hasCode() => this.code != null;

  bool hasMessage() => this.message != null;

  String toString() {
    String _code = this.code != null ? this.code.toString() + ' ' : '';
    return _code + (this.message ?? '');
  }

  static Failure cast(Failure failure) {
    return Failure(code: failure.code, message: failure.message);
  }
}
