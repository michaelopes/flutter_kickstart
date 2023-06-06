import 'package:dio/dio.dart';
import 'package:flutter_kickstart/src/http_driver/dio_client.dart';
import 'package:flutter_kickstart/src/interfaces/http_driver_interface.dart';

base class BaseRepository {
  IHttpDriver? _httpDriver;

  BaseRepository({IHttpDriver? httpDriver}) {
    _httpDriver = httpDriver;
  }

  IHttpDriver get httpDriver {
    _httpDriver ??= DioClient(Dio());
    return _httpDriver!;
  }

  void setHttpDriverMock(IHttpDriver httpDriver) {
    _httpDriver = httpDriver;
  }
}
