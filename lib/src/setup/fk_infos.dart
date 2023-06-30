import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

class FkInfos {
  static final FkInfos I = FkInfos._internal();
  FkInfos._internal();

  final deviceInfo = DeviceInfoPlugin();
  late final PackageInfo packageInfo;

  late final String deviceId;
  late final String buildNumber;
  late final String appName;
  late final String packageName;
  late final String buildSignature;
  late final String version;

  Future<void> init() async {
    packageInfo = await PackageInfo.fromPlatform();
    if (!kIsWeb) {
      if (Platform.isIOS) {
        deviceId = (await deviceInfo.iosInfo).identifierForVendor ?? "";
      } else {
        deviceId = (await deviceInfo.androidInfo).id;
      }
    } else {
      deviceId = (await deviceInfo.webBrowserInfo).browserName.name;
    }

    buildNumber = packageInfo.buildNumber;
    appName = packageInfo.appName;
    buildSignature = packageInfo.buildSignature;
    version = packageInfo.version;
    packageName = packageInfo.packageName;
  }
}
