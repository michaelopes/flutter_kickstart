import 'package:flutter_kickstart/src/http_driver/dio_client.dart';
import 'package:flutter_kickstart/src/interfaces/http_driver_interface.dart';

import '../core/fk_inject.dart';

abstract base class FkBaseRepository {
  IHttpDriver? _httpDriver;
  String? _baseUrl;

  final locator = FkInjectLocator();

  FkBaseRepository({IHttpDriver? httpDriver, String? baseUrl}) {
    _httpDriver = httpDriver;
    _baseUrl = baseUrl;
  }

  IHttpDriver get httpDriver {
    _httpDriver ??= DioClient(
      baseUrl: _baseUrl,
    );
    return _httpDriver!;
  }

  void setHttpDriverMock(IHttpDriver httpDriver) {
    _httpDriver = httpDriver;
  }
}
