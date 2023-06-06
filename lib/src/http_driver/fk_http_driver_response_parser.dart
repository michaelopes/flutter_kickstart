import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../util/fk_failures.dart';

abstract base class FkBaseHttpDriverResponseParser {
  FkHttpDriverResponse range100(FkHttpDriverResponse response) {
    return response;
  }

  FkHttpDriverResponse range200(FkHttpDriverResponse response);

  FkHttpDriverResponse range300(FkHttpDriverResponse response) {
    return response;
  }

  FkHttpDriverResponse range400(FkHttpDriverResponse response);
  FkHttpDriverResponse range500(FkHttpDriverResponse response);

  @mustCallSuper
  FkHttpDriverResponse success(dynamic response) {
    return range200(
      FkHttpDriverResponse(
        data: response.data,
        statusCode: response.statusCode,
        message: "",
      ),
    );
  }

  @mustCallSuper
  FkHttpDriverResponse error(Exception error) {
    if (error is DioError) {
      var errorReponse = FkHttpDriverResponse(
        message: error.message ?? "",
        statusCode: error.response?.statusCode ?? 400,
      );
      switch (error.response!.statusCode ?? 500) {
        case >= 300 && < 400:
          return range300(errorReponse);
        case >= 400 && < 500:
          return range400(errorReponse);
        case >= 500 && < 512:
        default:
          return range500(
            FkHttpDriverResponse(
              message: error.message ?? "",
              statusCode: error.response?.statusCode ?? 400,
            ),
          );
      }
    } else {
      return range200(
        FkHttpDriverResponse(
          statusCode: 500,
          message: error.toString(),
        ),
      );
    }
  }
}

final class FkDefaultHttpDriverResponseParser
    extends FkBaseHttpDriverResponseParser {
  @override
  FkHttpDriverResponse range200(FkHttpDriverResponse response) {
    return response;
  }

  @override
  FkHttpDriverResponse range400(FkHttpDriverResponse response) {
    return response;
  }

  @override
  FkHttpDriverResponse range500(FkHttpDriverResponse response) {
    return response;
  }
}

class FkHttpDriverResponse {
  final dynamic data;
  String code;
  final String message;
  final int statusCode;
  final FkFailure? failure;

  FkHttpDriverResponse({
    required this.statusCode,
    required this.message,
    this.data,
    this.code = "",
    this.failure,
  });

  bool get isSuccess => statusCode == 200 || statusCode == 201;

  void throwFailure() {
    if (failure != null) {
      throw failure!;
    } else {
      if (statusCode >= 400 && statusCode < 500) {
        throw FkHttpDriverServerBadResponseFailure(
          message: message,
          code: code,
          data: data,
          statusCode: statusCode,
        );
      } else if (statusCode >= 500 && statusCode <= 511) {
        throw FkHttpDriverServerFailure(
          statusCode: statusCode,
          message: message,
        );
      }
    }
  }

  FkHttpDriverResponse copyWith({
    dynamic data,
    String? code,
    FkFailure? failure,
  }) {
    return FkHttpDriverResponse(
      data: data ?? this.data,
      code: code ?? this.code,
      failure: failure ?? this.failure,
      statusCode: statusCode,
      message: message,
    );
  }
}
