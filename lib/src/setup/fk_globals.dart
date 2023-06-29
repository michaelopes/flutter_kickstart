library globals;

import '../http_driver/fk_http_driver_middleware.dart';
import '../http_driver/fk_http_driver_response_parser.dart';

FkBaseHttpDriverResponseParser httpDriverResponseParser =
    FkDefaultHttpDriverResponseParser();
IFkHttpDriverMiddleware httpDriverMiddleware = DefaultFkHttpDriverMiddleware();
String i18nDirectory = "";
String baseUrl = "";
bool enableHttpDriverLogger = true;
