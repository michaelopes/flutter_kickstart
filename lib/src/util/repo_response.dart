import 'dart:convert';
import '../core/fk_failures.dart';

class RepoResponse {
  final dynamic data;
  String code;
  final String message;
  final int statusCode;
  final String exception;
  RepoResponse({
    this.statusCode = 201,
    this.data,
    this.code = "",
    this.message = "",
    this.exception = "",
  });

  bool get isSuccess => statusCode == 200 || statusCode == 201;

  Failure get failure {
    if (statusCode >= 400 && statusCode < 500) {
      return ServerBadResponseFailure(
        message: message,
        code: code,
        data: data,
        statusCode: statusCode,
      );
    } else {
      return ServerFailure(
        statusCode: statusCode,
        message: message,
      );
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'data': data,
      'code': code,
      'message': message,
      'statusCode': statusCode,
      'exception': exception,
    };
  }

  factory RepoResponse.fromMap(Map<String, dynamic> map) {
    if ((map['code'] ?? "").isNotEmpty && (map['exception'] ?? "").isNotEmpty) {
      return RepoResponse(
        data: map['data'],
        code: map['code'],
        message: map['message'],
        statusCode: map['statusCode'],
        exception: map['exception'],
      );
    } else {
      return RepoResponse(
        data: map,
        code: "",
        message: "",
        statusCode: 201,
        exception: "",
      );
    }
  }

  String toJson() => json.encode(toMap());

  factory RepoResponse.fromJson(String source) =>
      RepoResponse.fromMap(json.decode(source));
}
