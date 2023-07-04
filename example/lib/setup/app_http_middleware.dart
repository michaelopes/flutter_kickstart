import 'package:flutter_kickstart/flutter_kickstart.dart';

class AppHttpMiddleware extends IFkHttpDriverMiddleware {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Access-Control-Allow-Origin'] = '*';
    return handler.next(options);
  }
}
