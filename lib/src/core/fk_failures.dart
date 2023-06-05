abstract class Failure implements Exception {
  Failure(this.message);
  final String message;
}

class ServerFailure extends Failure {
  ServerFailure({String message = "", int? statusCode})
      : super(
            "${statusCode != null ? "HttpCode: $statusCode | ExceptionMessage: " : "Exception message: "}$message");
}

class ApiFailure extends Failure {
  final Map<String, dynamic> data;
  final int httpCode;

  ApiFailure({String message = "", required this.data, required this.httpCode})
      : super(message);
}

class NoNetworkFailure extends Failure {
  NoNetworkFailure({String message = ""}) : super(message);
}

class ValidationFailure extends Failure {
  ValidationFailure({String message = ""}) : super(message);
}

class SessionNotFoundFailure extends Failure {
  SessionNotFoundFailure({String message = ""}) : super(message);
}

class ServerBadResponseFailure extends Failure {
  final String code;
  final int statusCode;
  final dynamic data;
  ServerBadResponseFailure({
    required String message,
    required this.code,
    required this.data,
    required this.statusCode,
  }) : super(message);
}
