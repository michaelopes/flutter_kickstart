library globals;

import '../http_driver/fk_http_driver_middleware.dart';
import '../http_driver/fk_http_driver_response_parser.dart';
import '../interfaces/fk_asset.dart';

FkBaseHttpDriverResponseParser httpDriverResponseParser =
    FkDefaultHttpDriverResponseParser();
IFkHttpDriverMiddleware httpDriverMiddleware = DefaultFkHttpDriverMiddleware();
List<FkAsset> assetsSnippeds = [];
String iconsDirectory = "";
String imagesDirectory = "";
String animationsDirectory = "";
String i18nDirectory = "";
bool enableHttpDriverLogger = true;
