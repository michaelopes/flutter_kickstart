import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../interfaces/http_driver_interface.dart';


/*
class DioClient implements IHttpDriver {
  final Dio dio;

  final HttpDriverOptions httpDriverOptions;

  DioClient(this.dio, this.httpDriverOptions) {
    _setConfig();
  }

  void _setConfig() {
    dio.options.headers.addAll(
      {
        'content-type': "application/json; charset=utf-8",
      },
    );
    dio.interceptors.addAll(
      [
       /* CustomInterceptor(
          dio,
          httpDriverOptions,
        ),*/
        if (httpDriverOptions.enableLogger)
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
  Future<HttpDriverResponse> interceptRequests(Future request) async {
    try {
      var response = await request.catchError((e) => throw e);
      var data0 = response.data;
      return HttpDriverResponse(data: data0, statusCode: response.statusCode);
    } on Exception catch (e) {
      switch (e.runtimeType) {
        case NoNetworkFailure:
          rethrow;
        case DioError:
          var dioError = (e as DioError);
          switch (dioError.response!.statusCode) {
            case 500:
              throw ServerFailure(
                message: dioError.message ?? "",
                statusCode: dioError.response?.statusCode,
              );
            case 503:
              throw ServerFailure(
                message: dioError.message ?? "",
                statusCode: dioError.response?.statusCode,
              );
            default:
              throw ApiFailure(
                message: dioError.message ?? "",
                data: dioError.response?.data is String
                    ? {
                        "exception": dioError.response!.data,
                        "message": dioError.response!.data,
                        "data": dioError.response!.data,
                        "code": "Error.UndefinedError",
                        "statusCode": 500,
                        "path": ""
                      }
                    : dioError.response?.data ?? {},
                httpCode: dioError.response!.statusCode ?? 0,
              );

            /*
              
              
              
               */
          }
        default:
          throw ServerFailure();
      }
    }
  }

  @override
  Future<HttpDriverResponse> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    String? key,
    HttpDriverOptions? options,
    HttpDriverProgressCallback? onReceiveProgress,
  }) async {
    dio.options.baseUrl = httpDriverOptions.baseUrl(key: key);
    dio.options.extra["key"] = key;
    resetContentType();
    return await interceptRequests(
      dio.get(path,
          queryParameters: queryParameters,
          onReceiveProgress: onReceiveProgress),
    );
  }

  @override
  Future<HttpDriverResponse> getFile<T>(
    String path, {
    String? key,
    Map<String, dynamic>? queryParameters,
    HttpDriverOptions? options,
  }) async {
    dio.options.baseUrl = httpDriverOptions.baseUrl(key: key);
    dio.options.extra["key"] = key;
    dio.options.headers['content-type'] = 'image/png';
    return await interceptRequests(
      dio.get(
        path,
        queryParameters: queryParameters,
      ),
    );
  }

  @override
  Future<HttpDriverResponse> patch(
    String path, {
    dynamic data,
    String? key,
    Map<String, dynamic>? queryParameters,
    HttpDriverOptions? options,
    HttpDriverProgressCallback? onReceiveProgress,
  }) async {
    dio.options.baseUrl = httpDriverOptions.baseUrl(key: key);
    dio.options.extra["key"] = key;
    resetContentType();
    return await interceptRequests(
      dio.patch(path,
          data: data,
          queryParameters: queryParameters,
          onReceiveProgress: onReceiveProgress),
    );
  }

  @override
  Future<HttpDriverResponse> post(
    String path, {
    dynamic data,
    String? key,
    Map<String, dynamic>? queryParameters,
    HttpDriverOptions? options,
    HttpDriverProgressCallback? onReceiveProgress,
  }) async {
    dio.options.baseUrl = httpDriverOptions.baseUrl(key: key);
    dio.options.extra["key"] = key;
    resetContentType();
    return await interceptRequests(
      dio.post(path,
          data: data,
          queryParameters: queryParameters,
          onReceiveProgress: onReceiveProgress),
    );
  }

  @override
  Future<HttpDriverResponse> put(
    String path, {
    dynamic data,
    String? key,
    Map<String, dynamic>? queryParameters,
    HttpDriverOptions? options,
    HttpDriverProgressCallback? onReceiveProgress,
  }) async {
    dio.options.baseUrl = httpDriverOptions.baseUrl(key: key);
    dio.options.extra["key"] = key;
    resetContentType();
    return await interceptRequests(
      dio.put(path,
          data: data,
          queryParameters: queryParameters,
          onReceiveProgress: onReceiveProgress),
    );
  }

  @override
  Future<HttpDriverResponse> delete<T>(
    String path, {
    dynamic data,
    String? key,
    Map<String, dynamic>? queryParameters,
    HttpDriverOptions? options,
  }) async {
    dio.options.baseUrl = httpDriverOptions.baseUrl(key: key);
    dio.options.extra["key"] = key;
    resetContentType();
    return await interceptRequests(
      dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
      ),
    );
  }

  @override
  void resetContentType() {
    dio.options.headers['content-type'] = 'application/json; charset=utf-8';
  }

  @override
  Future<HttpDriverResponse> sendFile<T>(
    String path, {
    dynamic data,
    String? key,
    Map<String, dynamic>? queryParameters,
    HttpDriverOptions? options,
    HttpDriverProgressCallback? onReceiveProgress,
    HttpDriverProgressCallback? onSendProgress,
  }) async {
    dio.options.baseUrl = httpDriverOptions.baseUrl(key: key);
    dio.options.extra["key"] = key;
    dio.options.headers['content-type'] = 'multipart/form-data';
    return await interceptRequests(
      dio.post<T>(
        httpDriverOptions.baseUrl(key: "file") + path,
        data: data,
        queryParameters: queryParameters,
        onReceiveProgress: onReceiveProgress,
      ),
    );
  }
}
*/