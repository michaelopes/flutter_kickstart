import 'package:flutter/material.dart';
import 'package:flutter_kickstart/src/interfaces/fk_asset.dart';
import 'package:flutter_kickstart/src/util/toolkit.dart';

import '../widgets/fp_icn.dart';

class FkIcons extends FkAsset {
  FkIcons(super.directory);

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
    return FpIcon(fileName: "$fileName.$ext", directory: directory);
  }
}

class FkIconsSnippetProvider extends FkIcons implements FkAssetSnippetProvider {
  FkIconsSnippetProvider() : super("");
  @override
  void setDirectory(String value) {
    super.directory = value;
  }
}

class FkDynamicIcons extends FkIcons {
  FkDynamicIcons(super.directory);
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
  final String directory;

  FpIcon({
    required String fileName,
    required this.directory,
    this.width,
    this.height,
    this.fit,
    this.color,
  }) {
    this.fileName = "${Toolkit.formatInputedDirectory(directory)}/$fileName";
  }

  Widget toIcon({double? width, double? height, BoxFit? fit, Color? color}) {
    if (directory.isEmpty) {
      var message =
          "Unable to load icon, iconsDirectory not given on FkTheme creation";
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
