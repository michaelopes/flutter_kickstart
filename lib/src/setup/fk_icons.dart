import 'package:flutter/material.dart';
import 'package:flutter_kickstart/src/interfaces/fk_asset.dart';
import 'package:flutter_kickstart/src/util/toolkit.dart';

import '../widgets/fp_icn.dart';
import 'fk_globals.dart' as globals;

class FkIcons extends FkAsset {
  @override
  T? tryGet<T>() {
    try {
      return FkIcons() as T;
    } catch (e) {
      return null;
    }
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    var fileName = Toolkit.getSymbolName(invocation.memberName);
    var ext = "svg";
    if (fileName.contains("\$")) {
      var split = fileName.split("\$");
      fileName = Toolkit.camelToUnderscore(split.first);
      ext = split.last.toLowerCase();
    } else {
      fileName = Toolkit.camelToUnderscore(fileName);
    }
    if (!["png", "svg"].contains(ext)) {
      var message =
          "Icon format $ext is not suported on FkIcons. Suported formats is PNG and SVG.";
      debugPrint(message);
      throw Exception(message);
    }
    return FpIcon(fileName: "$fileName.$ext");
  }
}

class FkDynamicIcons extends FkIcons {
  @override
  Widget noSuchMethod(Invocation invocation) {
    return super.noSuchMethod(invocation).toIcon();
  }
}

class FpIcon {
  late final String fileName;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Color? color;

  FpIcon({
    required String fileName,
    this.width,
    this.height,
    this.fit,
    this.color,
  }) {
    this.fileName =
        "${Toolkit.formatInputedDirectory(globals.iconsDirectory)}/$fileName";
  }

  Widget toIcon({double? width, double? height, BoxFit? fit, Color? color}) {
    if (globals.iconsDirectory.isEmpty) {
      var message = "Unable to load icon, iconsDirectory not given at Fk.init";
      debugPrint(message);
      throw Exception(message);
    }
    return fileName.contains("svg")
        ? FpIcn(
            fit: fit ?? (this.fit ?? BoxFit.contain),
            width: width ?? this.width,
            height: height ?? this.height,
            color: color ?? this.color,
            icon: fileName,
          )
        : Image.asset(
            fileName,
            fit: fit ?? this.fit,
            width: width ?? this.width,
            height: height ?? this.height,
          );
  }
}
