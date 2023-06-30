import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../interfaces/http_driver_interface.dart';

import '../setup/fk_globals.dart' as globals;
import 'fk_http_driver_response_parser.dart';

class _DioFactory {
  static Dio? _dio;
  static Dio get instance {
    _dio ??= Dio();
    return _dio!;
  }
}

class DioClient implements IHttpDriver {
  String? baseUrl;

  DioClient({
    this.baseUrl,
  }) {
    _setConfig();
  }

  Dio get dio => _DioFactory.instance;

  void _setConfig() {
    dio.options.baseUrl = baseUrl ?? globals.baseUrl;
    dio.options.headers.addAll(
      {
        'content-type': "application/json; charset=utf-8",
      },
    );
    dio.interceptors.addAll(
      [
        globals.httpDriverMiddleware..setHttpDriver(this),
        if (globals.enableHttpDriverLogger)
          PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseBody: true,
            responseHeader: false,
            error: true,
            compact: true,
            maxWidth: 90,
          )
      ],
    );
  }

  @override
  Future<FkHttpDriverResponse> interceptRequests(Future request) async {
    try {
      var response = await request.catchError((e) => throw e);
      return globals.httpDriverResponseParser.success(response);
    } on Exception catch (e) {
      return globals.httpDriverResponseParser.error(e);
    }
  }

  @override
  Future<FkHttpDriverResponse> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    HttpDriverProgressCallback? onReceiveProgress,
  }) async {
    resetContentType();
    return await interceptRequests(
      dio.get(
        path,
        queryParameters: queryParameters,
        onReceiveProgress: onReceiveProgress,
        options: options,
      ),
    );
  }

  @override
  Future<FkHttpDriverResponse> getFile<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    dio.options.headers['content-type'] = 'image/png';
    return await interceptRequests(
      dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      ),
    );
  }

  @override
  Future<FkHttpDriverResponse> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    HttpDriverProgressCallback? onReceiveProgress,
  }) async {
    resetContentType();
    return await interceptRequests(
      dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        onReceiveProgress: onReceiveProgress,
        options: options,
      ),
    );
  }

  @override
  Future<FkHttpDriverResponse> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    HttpDriverProgressCallback? onReceiveProgress,
  }) async {
    resetContentType();
    return await interceptRequests(
      dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        onReceiveProgress: onReceiveProgress,
        options: options,
      ),
    );
  }

  @override
  Future<FkHttpDriverResponse> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    HttpDriverProgressCallback? onReceiveProgress,
  }) async {
    resetContentType();
    return await interceptRequests(
      dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        onReceiveProgress: onReceiveProgress,
        options: options,
      ),
    );
  }

  @override
  Future<FkHttpDriverResponse> delete<T>(
    String path, {
    dynamic data,
    String? key,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    resetContentType();
    return await interceptRequests(
      dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      ),
    );
  }

  @override
  void resetContentType() {
    dio.options.headers['content-type'] = 'application/json; charset=utf-8';
  }

  @override
  Future<FkHttpDriverResponse> sendFile<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    HttpDriverProgressCallback? onReceiveProgress,
    HttpDriverProgressCallback? onSendProgress,
  }) async {
    dio.options.headers['content-type'] = 'multipart/form-data';
    return await interceptRequests(
      dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        onReceiveProgress: onReceiveProgress,
        options: options,
      ),
    );
  }
}
