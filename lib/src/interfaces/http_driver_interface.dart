final class HttpDriverResponse {
  final dynamic data;
  final int? statusCode;
  String? statusMessage;

  HttpDriverResponse({
    required this.data,
    required this.statusCode,
    this.statusMessage,
  });
}

abstract class HttpDriverOptions {
  final AccessToken accessToken;
  final UToken uToken;
  final CallbackByKey baseUrl;
  late final CallbackByKey? accessTokenType;
  final CallbackByKey apiKey;
  final String locationCode;

  final bool enableLogger;
  final String service;

  final String? deviceId;
  final String? buildNumber;
  final String? appName;
  final String? appVersion;
  final String? packageName;
  final String? buildSignature;

  HttpDriverOptions({
    required this.accessToken,
    required this.uToken,
    required this.baseUrl,
    required this.service,
    required this.apiKey,
    required this.locationCode,
    this.enableLogger = true,
    CallbackByKey? accessTokenType,
    this.deviceId,
    this.buildNumber,
    this.appName,
    this.packageName,
    this.buildSignature,
    this.appVersion,
  }) {
    if (accessTokenType == null) {
      this.accessTokenType = ({key}) => "Bearer";
    } else {
      this.accessTokenType = accessTokenType;
    }
  }
}

typedef HttpDriverProgressCallback = void Function(int count, int total);
typedef AccessToken = Future<String> Function();
typedef UToken = Future<String> Function();
typedef CallbackByKey = String Function({dynamic key});

typedef CallbackType<T> = T Function();

abstract class IHttpDriver {
  Future<dynamic> interceptRequests(Future request);
  Future<HttpDriverResponse> get(
    String path, {
    String? key,
    Map<String, dynamic>? queryParameters,
    HttpDriverOptions? options,
    HttpDriverProgressCallback? onReceiveProgress,
  });

  Future<HttpDriverResponse> patch(
    String path, {
    dynamic data,
    String? key,
    Map<String, dynamic>? queryParameters,
    HttpDriverOptions? options,
    HttpDriverProgressCallback? onReceiveProgress,
  });

  Future<HttpDriverResponse> put(
    String path, {
    dynamic data,
    String? key,
    Map<String, dynamic>? queryParameters,
    HttpDriverOptions? options,
    HttpDriverProgressCallback? onReceiveProgress,
  });

  Future<HttpDriverResponse> post(
    String path, {
    dynamic data,
    String? key,
    Map<String, dynamic>? queryParameters,
    HttpDriverOptions? options,
    HttpDriverProgressCallback? onReceiveProgress,
  });

  Future<HttpDriverResponse> delete<T>(
    String path, {
    dynamic data,
    String? key,
    Map<String, dynamic>? queryParameters,
    HttpDriverOptions? options,
  });

  Future<HttpDriverResponse> sendFile<T>(
    String path, {
    dynamic data,
    String? key,
    Map<String, dynamic>? queryParameters,
    HttpDriverOptions? options,
    HttpDriverProgressCallback? onReceiveProgress,
    HttpDriverProgressCallback? onSendProgress,
  });

  Future<HttpDriverResponse> getFile<T>(
    String path, {
    String? key,
    Map<String, dynamic>? queryParameters,
    HttpDriverOptions? options,
  });

  void resetContentType();
}
