import 'fk_http_driver_request.dart';

abstract interface class IFkHttpDriverMiddleware {
  Future<FkHttpDriverRequest> onRequest(FkHttpDriverRequest request);
}

final class DefaultFkHttpDriverMiddleware implements IFkHttpDriverMiddleware {
  @override
  Future<FkHttpDriverRequest> onRequest(FkHttpDriverRequest request) async {
    return request;
  }
}
