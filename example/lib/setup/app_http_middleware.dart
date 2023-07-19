import 'package:flutter_kickstart/flutter_kickstart.dart';

class AppHttpMiddleware extends FkHttpDriverMiddleware {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    return handler.next(options);
  }
}
