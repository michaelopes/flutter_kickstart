import 'package:dio/dio.dart';

final class FkHttpDriverRequest extends RequestOptions {
  final RequestOptions options;
  final RequestInterceptorHandler handler;

  FkHttpDriverRequest({
    required this.options,
    required this.handler,
  });

  FkHttpDriverRequest withAuthorization(String authorization) {
    options.headers["Authorization"] = authorization;
    return this;
  }
}
