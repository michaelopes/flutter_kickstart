import 'package:flutter_kickstart/flutter_kickstart.dart';

final class AppHttpResponseParser extends FkBaseHttpDriverResponseParser {
  @override
  FkHttpDriverResponse range200(FkHttpDriverResponse response) {
    return response;
  }

  @override
  FkHttpDriverResponse range400(FkHttpDriverResponse response) {
    return response;
  }

  @override
  FkHttpDriverResponse range500(FkHttpDriverResponse response) {
    return response;
  }
}
