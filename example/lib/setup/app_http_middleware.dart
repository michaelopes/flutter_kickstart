import 'package:flutter_kickstart/flutter_kickstart.dart';

class AppHttpMiddleware extends IFkHttpDriverMiddleware {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    return handler.next(options);
  }
}
