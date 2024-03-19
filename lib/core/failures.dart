class Failure {
  final String? message;
  const Failure({this.message});
}

// General failures
class ServerFailure extends Failure {
  ServerFailure({String? message}) : super(message: message);
}

class ReadFileFailure extends Failure {
  ReadFileFailure({String? message}) : super(message: message);
}

class CacheFailure extends Failure {
  CacheFailure({String? message}) : super(message: message);
}

class UnexpectedFailure extends Failure {}

class HttpFailure extends Failure {
  HttpFailure({String? message}) : super(message: message);
}
