import 'package:dio/dio.dart';
import '../../flutter_kickstart.dart';
import '../setup/fk_globals.dart' as globals;

class CustomInterceptor extends Interceptor {
  final Dio dio;
  CustomInterceptor(this.dio);
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    var res = await globals.httpDriverMiddleware.onRequest(
      FkHttpDriverRequest(
        handler: handler,
        options: options,
      ),
    );
    return super.onRequest(res.options, res.handler);
  }

  @override
  Future onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    return super.onResponse(response, handler);
  }

  @override
  // ignore: avoid_renaming_method_parameters
  Future<void> onError(DioError error, ErrorInterceptorHandler handler) async {
    return super.onError(error, handler);
  }
}
