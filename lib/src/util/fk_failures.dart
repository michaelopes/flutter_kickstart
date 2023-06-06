abstract class FkFailure implements Exception {
  FkFailure(this.message);
  final String message;
}

class FkHttpDriverServerFailure extends FkFailure {
  FkHttpDriverServerFailure({String message = "", int? statusCode})
      : super(
          "${statusCode != null ? "HttpCode: $statusCode | ExceptionMessage: " : "Exception message: "}$message",
        );
}

class FkHttpDriverGenericFailure extends FkFailure {
  final Map<String, dynamic> data;
  final int httpCode;

  FkHttpDriverGenericFailure({
    String message = "",
    required this.data,
    required this.httpCode,
  }) : super(message);
}

class FkHttpDriverServerBadResponseFailure extends FkFailure {
  final String code;
  final int statusCode;
  final dynamic data;
  FkHttpDriverServerBadResponseFailure({
    required String message,
    required this.code,
    required this.data,
    required this.statusCode,
  }) : super(message);
}
