library globals;

import '../core/fk_app_middleware.dart';
import '../http_driver/fk_http_driver_middleware.dart';
import '../http_driver/fk_http_driver_response_parser.dart';

FkBaseHttpDriverResponseParser httpDriverResponseParser =
    FkDefaultHttpDriverResponseParser();
FkHttpDriverMiddleware httpDriverMiddleware = DefaultFkHttpDriverMiddleware();
FkModuleMiddleware? moduleMiddleware;
String i18nDirectory = "";
String baseUrl = "";
bool enableHttpDriverLogger = true;
