import 'package:dio/dio.dart';
import 'package:flutter_kickstart/src/interfaces/http_driver_interface.dart';

abstract class IFkHttpDriverMiddleware extends Interceptor {
  IHttpDriver? httpDriver;
  void setHttpDriver(IHttpDriver httpDriver) {
    this.httpDriver = httpDriver;
  }
}

final class DefaultFkHttpDriverMiddleware extends IFkHttpDriverMiddleware {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    return handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    return handler.next(options);
  }
}
