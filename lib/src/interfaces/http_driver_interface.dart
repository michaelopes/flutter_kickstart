import 'package:dio/dio.dart';
import 'package:flutter_kickstart/src/http_driver/fk_http_driver_response_parser.dart';

typedef HttpDriverProgressCallback = void Function(int count, int total);
typedef AccessToken = Future<String> Function();
typedef UToken = Future<String> Function();
typedef CallbackByKey = String Function({dynamic key});

typedef CallbackType<T> = T Function();

abstract class IHttpDriver {
  Future<dynamic> interceptRequests(Future request);
  Future<FkHttpDriverResponse> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    HttpDriverProgressCallback? onReceiveProgress,
  });

  Future<FkHttpDriverResponse> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    HttpDriverProgressCallback? onReceiveProgress,
  });

  Future<FkHttpDriverResponse> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    HttpDriverProgressCallback? onReceiveProgress,
  });

  Future<FkHttpDriverResponse> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    HttpDriverProgressCallback? onReceiveProgress,
  });

  Future<FkHttpDriverResponse> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  });

  Future<FkHttpDriverResponse> sendFile<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    HttpDriverProgressCallback? onReceiveProgress,
    HttpDriverProgressCallback? onSendProgress,
  });

  Future<FkHttpDriverResponse> getFile<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  });

  void resetContentType();
}
